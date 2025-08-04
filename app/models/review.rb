class Review < ApplicationRecord
  belongs_to :book

  attribute :banned, :boolean, default: false

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :content, length: { maximum: 1000 }, allow_blank: true
end
