# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default("f")
#  name                   :string
#  address                :string
#

class User < ApplicationRecord
  has_many :reviews

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
