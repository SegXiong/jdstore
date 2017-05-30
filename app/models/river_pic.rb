class RiverPic < ApplicationRecord
  mount_uploader :rvatar, RvatarUploader
  belongs_to :product
end
