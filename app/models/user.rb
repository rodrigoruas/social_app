class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :username, presence: true

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :conversation_users
  has_many :conversations, through: :conversation_users
  has_many :messages, foreign_key: :from_user_id

  def full_name
    "#{first_name} #{last_name}"
  end
end
