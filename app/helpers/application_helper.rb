module ApplicationHelper

  def current_order
    Order.find(session[:order_id])
  end
end

def adjust_length(string, length: 40)
  if string.size > 40
    return string[0..40] + "..."
  else
    string
  end
end