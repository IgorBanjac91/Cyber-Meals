module ApplicationHelper

  def current_order
    Order.find(session[:order_id])
  end
end

def adjust_length(string, length = 40)
  if string.size > length
    return string[0..length] + "..."
  else
    string
  end
end

def admin_signed_in?
  user_signed_in? ? current_user.admin? : false
end