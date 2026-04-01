class Comment < ApplicationRecord
  has_one_attached :image
  validates :body, presence: true
end
