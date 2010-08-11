class Defect < ActiveRecord::Base
  has_many :apar_defect_version_maps
  has_many :upd_pc_views
  
  # Secondary relations
  has_many :apars,                :through => :apar_defect_version_maps
  has_many :versions,             :through => :apar_defect_version_maps
  has_many :adv_ptf_release_maps, :through => :apar_defect_version_maps

  def ptfs
    self.adv_ptf_release_maps.map { |m| m.ptf }
  end

  def releases
    self.adv_ptf_release_maps.map { |m| m.release }
  end

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
