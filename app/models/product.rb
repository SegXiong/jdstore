# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  quantity    :integer
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#  friendly_id :string
#  category_id :integer
#  user_id     :integer
#

class Product < ApplicationRecord
  has_many :reviews

  has_many :river_pics, :dependent => :destroy

  has_many :favorites
  has_many :members, :through => :favorites, :source => :user

  belongs_to :category, :optional => true

  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos, :river_pics

  mount_uploader :image, ImageUploader

  validates_presence_of :friendly_id, :title
  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

  before_validation :generate_friendly_id, :on => :create

  def to_param
    self.friendly_id

  end

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid

  end
end
