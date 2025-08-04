class Book < ApplicationRecord
  has_many :reviews

  def average_rating
    valid_reviews = reviews.where(banned: false)

    return "Reseñas Insuficientes" if valid_reviews.count < 3

    avg = valid_reviews.average(:rating).to_f
    avg.round(1)
  end
end
