class Lpp < ActiveRecord::Base
  belongs_to :lpp_base
  has_many :filesets
end
