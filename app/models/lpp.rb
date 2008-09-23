class Lpp < ActiveRecord::Base
  belongs_to :lpp_base
  has_many :filesets

  def <=>(other)
    self.name <=> other.name
  end
end
