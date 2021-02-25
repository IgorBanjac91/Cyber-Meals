module OrdersHelper

  def pretty_format(date)
    date.strftime("%Y-%m-%d")
  end
end