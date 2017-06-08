# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Cart < ApplicationRecord
  has_many :cart_items
  has_many :products, through: :cart_items, source: :product

  belongs_to :user, :optional => true

  def add_product_to_cart(product, quantity)
    ci = cart_items.build
    ci.product = product
    ci.quantity = quantity
    ci.save

  end

  def total_price
    sum = 0
    cart_items.each do |cart_item|
      if cart_item.product.price.present?
         sum += cart_item.quantity * cart_item.product.price
      end
    end
    sum

  end

  def clean!
    cart_items.destroy_all

  end

  def merge!(cart)
    cart.cart_items.each do |item|
      add_product_to_cart(item.product, item.quantity)
    end

  end
end
