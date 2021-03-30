module ApplicationHelper


  def pretty_date(date)
    date.strftime("%Y-%m-%d")
  end

  def pretty_price(price)
    "$#{price}"
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