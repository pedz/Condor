class ImagePath < ActiveRecord::Base
  belongs_to :package

  def <=>(other)
    path <=> other.path
  end
end
