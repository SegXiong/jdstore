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

  has_many :likes
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
      self.likes.where(:user_id => user.id).first
  end
end
