module Admin::OrdersHelper
  def render_order_paid_state(order)
    if order.is_paid?
      t("admin.paid")
    else
      t("admin.unpaid")

    end

  end
end
