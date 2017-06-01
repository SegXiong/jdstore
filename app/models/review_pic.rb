# == Schema Information
#
# Table name: review_pics
#
#  id         :integer          not null, primary key
#  review_id  :integer
#  avatar     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReviewPic < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :review
end
