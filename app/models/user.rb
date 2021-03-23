class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  validates :first_name, :last_name, presence: true
  validates :username, length: { minimum: 2, maximum: 32 }

  has_many :orders

  has_many :reviews 
  has_many :items, through: :reviews

  def full_name
    "#{first_name} #{last_name}"
  end
end
