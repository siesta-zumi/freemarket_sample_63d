class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many_attached :item_images
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  has_many :likes
  has_many :messages
  
  # 誰がいいねしたかなど表示するときに使う
  has_many :liked_users, through: :likes, source: :user

  ##########ActiveHash####################
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  ##########validation####################
  validates :name, presence: true
  validates :description, presence: true
  validates :is_bear_shipping_cost, presence: true
  validates :period, presence: true
  validates :price, presence: true
  validate :selected_category?
  validates :brand_id, presence: true
  validates :user_id, presence: true
  validates :status, presence: true
  validates :selling_status, presence: true
  validate :image_presence

  def image_presence
    if !item_images.attached?
      errors.add(:item_images, 'ファイルを添付してください')
    end
  end

  def selected_category?

    # category_idが0かnilの場合、即エラー
    if category_id == 0 || category_id == nil
      errors.add(:category_id, 'カテゴリーが正しく選択されていません')
    else
      # 選択されたカテゴリーが親とさらにその親を持たない場合はエラー
      selected_category = Category.find(category_id)
      if selected_category == nil || selected_category.parent == nil || selected_category.parent.parent == nil
        errors.add(:category_id, 'カテゴリーが正しく選択されていません')
      end
    end

  end
end
