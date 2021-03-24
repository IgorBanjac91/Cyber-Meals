class Review < ApplicationRecord

  belongs_to :user
  belongs_to :item

  def within_15_minutes?
    created_at - Time.now < 15.minutes ? true : false
  end
end
