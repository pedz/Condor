#!/usr/bin/env ruby

# This module is able to parse a toc file.  lpp_name is one form of a
# toc file and the other form is the .toc file generated by inutoc.
# The small paragraph of code at the bottom is an example of how to
# call it.

module Toc
  class Fileset
    attr_reader :name, :vrmf, :volumn, :bosboot, :content, :language
    attr_reader :description, :reqs, :sizes, :superceeds, :temps, :fixes

    def initialize(name, vrmf, volumn, bosboot, content, language, description,
                   reqs, sizes, superceeds, temps, fixes)
      @name = name
      @vrmf = vrmf.sub(/^0+(\d)/, "\\1").gsub(/\.0+(\d)/, ".\\1")
      @volumn = volumn
      @bosboot = bosboot
      @content = content
      @language = language
      @description = description
      @reqs = reqs
      @sizes = sizes
      @superceeds = superceeds
      @temps = temps
      @fixes = fixes
    end
    
    Pattern = Regexp.new('(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+([^#]+)( *(#.*))?$')
    def self.parse(line, file)
      unless (md = Pattern.match(line))
        raise "Parse error: line #{file.lineno} Bad fileset line \"#{line}\""
      end
      
      unless (line = file.gets) && line.chomp! == "["
        raise "Parse error: line #{file.lineno} \"[\" expected"
      end
      
      reqs = []
      while (line = file.gets) && line.chomp! != '%' && line != ']'
        reqs << line
      end

      sizes = []
      if line != ']'
        while (line = file.gets) && line.chomp! != '%' && line != ']'
          sizes << line
        end
      end

      superceeds = []
      if line != ']'
        while (line = file.gets) && line.chomp! != '%' && line != ']'
          superceeds << line
        end
      end

      temps = []
      if line != ']'
        while (line = file.gets) && line.chomp! != '%' && line != ']'
          temps << line
        end
      end

      fixes = []
      if line != ']'
        while (line = file.gets) && line.chomp! != ']'
          fixes << line
        end
      end
      raise "Parse error: line #{file.lineno} \"]\" expected" unless line == "]"
      new(md[1], md[2], md[3], md[4], md[5], md[6], md[7],
          reqs, sizes, superceeds, temps, fixes)
    end
  end

  class Package
    attr_reader :filepath, :format, :platform, :type, :name, :filesets

    def initialize(filepath, format, platform, type, name, filesets)
      @filepath = filepath
      @format = format
      @platform = platform
      @type = type
      @name = name
      @filesets = filesets
    end
    
    def self.parse(line, file)
      fields = line.split
      if fields.length == 6
        filepath = fields.shift
      else
        filepath = nil
      end
      format, platform, type, name, brace = fields
      filesets = []
      if brace != "{"
        raise "Parse error: line #{file.lineno} \"{\" expected in package.  Got \"#{line}\""
      end
      
      while (line = file.gets) && line.chomp! != "}"
        filesets << Fileset.parse(line, file)
      end
      new(filepath, format, platform, type, name, filesets)
    end
  end

  class Parser
    def self.parse(file)
      first_time = true
      packages = []
      while line = file.gets
        line.chomp!
        # A .toc has the first line which is some gook that needs to
        # be skipped.  As far as I know, an lpp_name can have only one
        # package in it but I don't make that assumption here.
        if first_time && ! line.match(/\{$/)
          next
        end
        first_time = false
        raise "Parse error: line #{file.lineno} \"{\" expected" unless line.match(/\{$/)
        packages << Package.parse(line, file)
      end
      packages
    end
  end
end

# If this is run as a command:
if $0 == __FILE__
  if ARGV.length != 1
    $stderr.write "Usage: $0 <path-to-toc>\n"
    exit 1
  end

  File.open(ARGV[0]) do |f|
    packages = Toc::Parser.parse(f)
    
    packages.each do |package|
      package.filesets.each do |fileset|
        puts "#{package.name} #{fileset.name} #{fileset.vrmf}"
      end
    end

    # packages.each do |package|
    #   package.filesets.each do |fileset|
    #     unless fileset.sizes.empty?
    #       puts "#{package.name} #{fileset.name}:"
    #       fileset.sizes.each { |l| puts l }
    #     end
    #   end
    # end
  end
end
