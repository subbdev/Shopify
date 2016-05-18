class Image < ActiveRecord::Base
  belongs_to :product
  has_attached_file :attachment
end
