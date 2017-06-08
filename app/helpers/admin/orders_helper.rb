module Admin::OrdersHelper
  def render_order_paid_state(order)
    if order.is_paid?
      content_tag(:span, t("admin.paid"), class: "label label-success")
    else
      content_tag(:span, t("admin.unpaid"), class: "label label-default")

    end

  end
end
