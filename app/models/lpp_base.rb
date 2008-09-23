class LppBase < ActiveRecord::Base
  has_many :lpps

  def <=>(other)
    self.name <=> other.name
  end
end
