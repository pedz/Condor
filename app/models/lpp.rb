class Lpp < ActiveRecord::Base
  belongs_to :base
  has_many :filesets
end
