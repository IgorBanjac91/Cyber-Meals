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

def admin_signed_in?
  user_signed_in? ? current_user.admin? : false
end

def regular_user_signed_in?
  !admin_signed_in?
end