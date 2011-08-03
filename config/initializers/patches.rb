# -*- coding: utf-8 -*-
#
# Copyright 2007-2011 Ease Software, Inc. and Perry Smith
# All Rights Reserved
#
module ActiveRecord
  module ConnectionAdapters
    class PostgreSQLAdapter
      def disable_referential_integrity(&block)
        transaction {
          begin
            execute "SET CONSTRAINTS ALL DEFERRED"
            yield
          ensure
            execute "SET CONSTRAINTS ALL IMMEDIATE"
          end
        }
      end
    end
  end
end
