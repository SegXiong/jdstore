class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :review_pics, :dependent => :destroy
  accepts_nested_attributes_for :review_pics
  validates_presence_of :content
end
