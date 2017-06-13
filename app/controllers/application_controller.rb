class ApplicationController < ActionController::Base
  before_action :store_current_location, :unless => :devise_controller?
  protect_from_forgery with: :exception

  before_action :set_locale

  def admin_required
    if !current_user.admin?
      redirect_to "/", alert: t("not-admin")

    end

  end

  helper_method :current_cart

  def current_cart
    if current_user
      @current_cart ||= find_cart
    else
      @current_cart ||= find_session_cart

    end

  end

  private

  def find_cart
    cart = current_user.cart
    if cart.blank?
      cart = Cart.create
      current_user.cart = cart

    end
    session_cart = find_session_cart
    unless session_cart.blank?
      cart.merge!(session_cart)
      session_cart.clean!
    end
    return cart

  end

  def find_session_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create!
    end
    session[:cart_id] = cart.id
    return cart

  end

  def set_locale
    if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
      session[:locale] = params[:locale]

    end
    I18n.locale = session[:locale] || I18n.default_locale

  end

  def store_current_location
    store_location_for(:user, request.url)

  end
end
