module OrdersHelper
  def render_order_status(order)
    case order.aasm_state
    when 'order_placed'
      content_tag(:span, t('order-status-placed'), class: "label label-danger")
    when 'paid'
      content_tag(:span, t('order-status-paid'), class: "label label-info")
    when 'shipping'
      content_tag(:span, t('order-status-shipping'), class: "label label-primary")
    when 'shipped'
      content_tag(:span, t('order-status-shipped'), class: "label label-success")
    when 'order_cancelled'
      content_tag(:span, t('order-status-cancelled'), class: "label label-default")
    when 'good_returned'
      content_tag(:span, t('order-status-returned'), class: "label label-waring")
    end
  end

end
