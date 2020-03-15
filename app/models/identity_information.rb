class IdentityInformation < ApplicationRecord
  belongs_to :user

  ##validation###############################
  validates :user_id,               presence: true
  validates :first_name,            presence: true
  validates :last_name,             presence: true
  validates :first_name_furigana,   presence: true
  validates :last_name_furigana,    presence: true
  validates :birthday,              presence: true

  #全角入力 validation
  validates :first_name,            format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :last_name,             format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name_furigana,   format: { with: /\A[ぁ-んー－]+\z/ }
  validates :last_name_furigana,    format: { with: /\A[ぁ-んー－]+\z/ }

end
