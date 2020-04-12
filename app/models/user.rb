class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  has_one_attached :avatar
  has_many :items
  has_one :card
  has_one :identity_information
  has_one :shipping_address
  has_many :orders
  has_many :items, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_items, through: :likes, source: :item
  has_many :messages
  
  def already_liked?(item)
    self.likes.exists?(item_id: item.id)
  end
end
