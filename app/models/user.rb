class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  validates :first_name, :last_name, presence: true
  validates :username, length: { minimum: 2, maximum: 32 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
