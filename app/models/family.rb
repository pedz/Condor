class Family < ActiveRecord::Base
  has_many :releases

  def <=>(other)
    this.name <=> other.name
  end
end
