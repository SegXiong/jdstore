# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  product_id :integer
#  user_id    :integer
#  content    :text
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :review_pics, :dependent => :destroy
  accepts_nested_attributes_for :review_pics
  validates_presence_of :content
end
