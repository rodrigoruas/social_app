class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :username, presence: true    
  
  has_many :likes, dependent: :destroy

  has_many :liked_posts, through: :likes, source: :post

  def full_name
    "#{first_name} #{last_name}"
  end         
end
