class Version < ActiveRecord::Base
  has_many :releases

  def <=>(other)
    self.name <=> other.name
  end
end
