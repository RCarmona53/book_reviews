require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { Book.create!(title: "Book Test") }

  context "average rating calculation" do
    it "returns the average rating rounded to one decimal" do
      book.reviews.create!(rating: 5)
      book.reviews.create!(rating: 3)
      book.reviews.create!(rating: 4)

      expect(book.average_rating).to eq(4.0)
    end

    it "ignores reviews from banned users" do
      book.reviews.create!(rating: 5, banned: false)
      book.reviews.create!(rating: 4, banned: false)
      book.reviews.create!(rating: 3, banned: true)
      book.reviews.create!(rating: 2, banned: false)

      expect(book.average_rating).to eq(3.7)
    end
  end

  context "minimum reviews" do
    it "shows 'Reseñas Insuficientes' if less than 3 valid reviews" do
      book.reviews.create!(rating: 5)
      book.reviews.create!(rating: 4)

      expect(book.average_rating).to eq("Reseñas Insuficientes")
    end
  end
end
