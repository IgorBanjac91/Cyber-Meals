class User < ApplicationRecord
  after_create :add_stripe_customer

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

  protected 

    def add_stripe_customer
      customer = Stripe::Customer.create({
        email: self.email,
        name: full_name
      })
      update(stripe_customer_id: customer.id )
    end
end
