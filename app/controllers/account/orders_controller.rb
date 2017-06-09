class Account::OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order("id DESC").paginate(:page => params[:page], :per_page => 20 )

  end
end
