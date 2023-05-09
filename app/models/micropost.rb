class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  # user_idが存在している必要がある
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
