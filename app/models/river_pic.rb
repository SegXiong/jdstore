# == Schema Information
#
# Table name: river_pics
#
#  id         :integer          not null, primary key
#  product_id :integer
#  rvatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RiverPic < ApplicationRecord
  mount_uploader :rvatar, RvatarUploader
  belongs_to :product
end
