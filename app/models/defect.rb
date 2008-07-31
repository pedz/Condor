class Defect < ActiveRecord::Base
  has_many :apar_defect_ptf_release_maps
  
  # Secondary relations
  has_many :apars,  :through => :apar_defect_ptf_release_maps
  has_many :ptfs,     :through => :apar_defect_ptf_release_maps
  has_many :releases, :through => :apar_defect_ptf_release_maps

  def text
    lines = []
    string = "/usr/contrib/bin/Defect \
                -view #{name} \
                -become pedzan \
                -long \
                2> /dev/null || \
              /usr/contrib/bin/Feature \
                -view #{name} \
                -become pedzan \
                -long \
                2> /dev/null"
    puts(string)
    IO.popen(string) do |io|
      lines = io.readlines
    end
    lines
  end

  def <=>(other)
    this.name <=> other.name
  end
end
