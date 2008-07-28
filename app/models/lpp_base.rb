class LppBase < ActiveRecord::Base
  has_many :lpps

  def <=>(other)
    this.name <=> other.name
  end
end
