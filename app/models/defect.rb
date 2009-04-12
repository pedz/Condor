class Defect < ActiveRecord::Base
  has_many :apar_defect_version_maps
  
  # Secondary relations
  has_many :apars,   :through => :apar_defect_version_maps
  has_many :ptfs,    :through => :apar_defect_version_maps
  has_many :version, :through => :apar_defect_version_maps

  def text
    return @lines unless @lines.nil? || @lines.empty?
    @lines = []
    string = "/usr/local/cmvc/bin/Defect \
                -view #{name} \
                -family aix \
                -become pedzan \
                -long \
                2> /dev/null || \
              /usr/local/cmvc/bin/Feature \
                -view #{name} \
                -family aix \
                -become pedzan \
                -long \
                2> /dev/null"
    puts(string)
    IO.popen(string) do |io|
      @lines = io.readlines
    end
    @lines
  end

  def <=>(other)
    self.name <=> other.name
  end
end
