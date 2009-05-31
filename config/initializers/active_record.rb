#
# This is the third generation of this file at this time.  The
# original is in "books" under ~pedz.  Then it was enhanced in
# shikra.  And now I've moved it to here.  I assume I will treak on
# it in this project.
#
module ActiveRecord
  module ConnectionAdapters
    # Module that will be included in other modules to reduce
    # duplication.  It implements some utility routines that
    # contraints use.
    module Constraints
      # Utility routine to produce the common part (which is most) of
      # the "references" clause.
      def reference_str(column, options)
        Rails.logger.debug("IN: Constraints#reference_str")
        local_options = { }
        if md = /(.*)_id$/.match(column.to_s)
          local_options[:table_name] = md[1].pluralize
          local_options[:foreign_key] = "id"
        end
        local_options.merge!(options)
        ref_column_str = column_to_str(local_options[:foreign_key])
        ref_str = " REFERENCES #{local_options[:table_name]} (#{ref_column_str})"
        if local_options.has_key? :delete
          ref_str << " ON DELETE #{local_options[:delete].to_s.upcase}"
        end
        if local_options.has_key? :deferrable
          if local_options[:deferrable] == false
            ref_str << " NOT"
          end
          ref_str << " DEFERRABLE"
        end
        if local_options.has_key? :initially
          ref_str << " INITIALLY #{local_options[:initially].to_s.upcase}"
        end
        ref_str
      end
      
      # Utility routine to return the column or the array of columns
      # as a string.
      def column_to_str(column)
        Rails.logger.debug("IN: Constraints#column_to_str")
        if column.is_a? Array
          column.map { |c| "\"#{c.to_s}\""}.join(", ")
        else
          "\"#{column.to_s}\""
        end
      end
    end
    
    module SchemaStatements
      # When base.add_column_options_with_constraints! is called by
      # ColumnDefinition#add_column_options_with_constraints! it ends
      # up calling
      # SchemaStatements#add_column_options_with_constraints!.  We
      # capture that call as well so that we can append the unique and
      # references clauses to the sql statement.
      def add_column_options_with_constraints!(sql, options)
        Rails.logger.debug("IN: SchemaStatements#add_column_options_with_constraints!")
        extend Constraints
        add_column_options_without_constraints!(sql, options)
        if options.has_key?(:unique) && options[:unique]
          sql << " UNIQUE"
        end
        if options[:reference]
          sql << reference_str(options[:column].name, options)
        end
      end
      alias_method_chain :add_column_options!, :constraints
    end
    
    class ColumnDefinition
      # Will contain all the options used on a column definition
      def options
        Rails.logger.debug("IN: ColumnDefinition#options")
        @options
      end

      # Called from TableDefinition#column_with_constraints so we
      # remember the options for each column being defined.
      def options=(arg)
        Rails.logger.debug("IN: ColumnDefinition#options=")
        @options = arg
      end

      # ColumnDefinition@add_column_options! is called which calls
      # base.add_column_options! by to_sql of ColumnDefinition.  We
      # capture this call so that we can merge in the options we are
      # interested in (namely, all of the original options used in to
      # create the column
      def add_column_options_with_constraints!(sql, options)
        Rails.logger.debug("IN: ColumnDefinition#add_column_options_with_constraints!")
        add_column_options_without_constraints!(sql, options.merge(@options))
      end
      alias_method_chain :add_column_options!, :constraints
    end

    class TableDefinition
      include Constraints

      # "fk" stands for foreign key.  This is more like a macro that
      # defines a column that is a foreign key.  This is a "rough
      # draft" version of this routine.
      def fk(*names)
        self.integer(names, {
                       :null => false,
                       :reference => true,
                       :delete => :cascade,
                       :deferrable => true })
      end
      
      # As the table is being defined, we capture the call to column.
      # column (now called column_with_constraints returns self which
      # is a TableDefinition. TableDefinition#[] returns the column
      # for the name passed.  We add an @options attribute for later
      # use (see ColumnDefinition#options=).
      def column_with_constraints(name, type, options = { })
        Rails.logger.debug("IN: TableDefinition#column_with_constraints for #{name}")
        ret = column_without_constraints(name, type, options)
        ret[name].options = options
        ret
      end
      alias_method_chain :column, :constraints
      
      # to_sql is called to transform the table definition into an sql
      # statement.  We insert ourselves into that so that we can
      # append the extra string needed for the constraints added by
      # the `unique' and `references' table definition methods.
      def to_sql_with_constraints
        Rails.logger.debug("IN: TableDefinition#to_sql_with_constraints")
        to_sql_without_constraints + extra_str
      end
      alias_method_chain :to_sql, :constraints
      
      # Add a "unique" method to TableDefinition.  e.g.
      #   create_table :users do |t|
      #     t.string  :name,  :null    => false
      #     t.boolean :admin, :default => false
      #     t.timestamps
      #     t.unique :name
      #   end
      #
      # Pass a list of items.  An item may be a single column name or
      # an array of column names.  Appends to extra_str string either:
      # UNIQUE (column)
      #  or when an array is passed:
      # UNIQUE (column1, column2, ...)
      #
      def unique(*args)
        Rails.logger.debug("IN: TableDefinition#unique")
        args.each { |arg| extra_str << ", UNIQUE (#{column_to_str(arg)})" }
      end

      # Pass a column and options (which may be empty).  The column
      # name of foo_id, by default, creates a reference to table foos,
      # column id.  :table_name may be passed in options to specify
      # the foreign table name.  :foreign_key may be passed to specify the
      # foreign column.
      # Both the passed in column (first argument) as well as thee
      # :foreign_key option may be an array.
      # :delete option may be passed in with the appropriate value
      # such as :restrict, :cascade, etc.
      def reference(column, options = { })
        Rails.logger.debug("IN: TableDefinition#reference")
        extra_str << ", FOREIGN KEY (#{column_to_str(column)})" + reference_str(column, options)
      end

      private

      def extra_str
        Rails.logger.debug("IN: TableDefinition#extra_str")
        @extra_str ||= ""
      end

      def extra_str=(arg)
        Rails.logger.debug("IN: TableDefinition#extra_str=")
        @extra_str = arg
      end
    end
  end

  class Base
    class << self
      @pg_class = nil
      @pg_constraints = nil
      @pg_constraint_hash = nil
      @pg_attributes = nil
      @pg_attribute_hash = nil

      def pg_class
        @pg_class ||= PgClass.find_by_relname(table_name)
      end

      def pg_constraints
        if @pg_constraints.nil?
          @pg_constraints = PgConstraint.find(:all,
                                              :joins => :conrel,
                                              :conditions => { :pg_class => { :relname => table_name }})
          @pg_constraint_hash = Hash.new
          @pg_constraints.each { |c|
            Rails.logger.debug("Adding '#{c.conname}' to constraint_hash")
            @pg_constraint_hash[c.conname] = c
          }
        end
        @pg_constraints
      end

      def pg_constraint_hash
        @pg_constraint_hash
      end

      def pg_attributes
        if @pg_attributes.nil?
          @pg_attributes = PgAttribute.find(:all,
                                            :joins => :attrel,
                                            :conditions => { :pg_class => { :relname => table_name }})
          @pg_attribute_hash = Hash.new
          @pg_attributes.each { |a| @pg_attribute_hash[a.attnum] = a }
        end
        @pg_attributes
      end

      def pg_attribute_hash
        @pg_attribute_hash
      end

      # We can not rummage around in the database after an error has
      # occurred or we will get back more errors that an error has
      # already occurred and further queries will be ignored.  So, we
      # pre-fetch the system tables that we need and save them in our
      # pockets.
      def pre_fetch
        if @pg_class.nil?
          pg_class
          pg_constraints
          pg_attributes
        end
      end

      def constraint_to_columns(constraint)
        Rails.logger.debug("constraint_to_columns: '#{constraint}' (#{constraint.class})")
        k = pg_constraint_hash[constraint].conkey
        k[1 ... (k.length - 1)].
          split(',').
          map{ |s| pg_attribute_hash[s.to_i].attname }
      end
    end

    NOT_NULL_REGEXP = Regexp.new("PGError: +ERROR: +null value in column \"([^\"]*)\" violates not-null constraint")
    UNIQUE_REGEXP = Regexp.new("PGError: +ERROR: +duplicate key violates unique constraint \"([^\"]+)\"")
    FOREIGN_REGEXP = Regexp.new("PGError: +ERROR: +insert or update on table \"([^\"]+)\" violates " +
                                "foreign key constraint \"([^\"]+)\"")
    def save_with_constraints(perform_validation = true)
      self.class.pre_fetch
      begin
        save_without_constraints(perform_validation)
      rescue ActiveRecord::StatementInvalid => e
        logger.debug("trace_report save error is '#{e.message}'")
        if md = NOT_NULL_REGEXP.match(e.message)
          errors.add(md[1].to_sym, "can't be blank")
        elsif md = UNIQUE_REGEXP.match(e.message)
          constraint = md[1]
          ffoo(constraint, "has already been taken")
        elsif md = FOREIGN_REGEXP.match(e.message)
          table = md[1]
          constraint = md[2]
          ffoo(constraint, "is invalid")
        else
          logger.debug("Nothing matched")
        end
        false
      end
    end
    alias_method_chain :save, :constraints

    private
    def ffoo(constraint, message)
      Rails.logger.debug("constraint: '#{constraint.inspect}', message: #{message}")
      c = constraint.to_sym
      # define a method in the model with the same name as the
      # constraint and it will be called so it can do whatever it
      # wants to.
      if self.respond_to? c
        self.send c
      else
        columns = self.class.constraint_to_columns(constraint)
        Rails.logger.debug("columns are: #{columns.inspect}")
        columns.each { |name| errors.add(name, message) }
      end
    end
  end
end
