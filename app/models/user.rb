class User < ApplicationRecord
  has_many :favorites
  has_many :collected_products, :through => :favorites, :source => :product

  has_many :orders
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    is_admin

  end

  def display_name
    self.email.split("@").first

  end

  def has_collected?(product)
    collected_products.include?(product)

  end

  def collect!(product)
    collected_products << product

  end

  def discollect!(product)
    collected_products.delete(product)

  end
end
