require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { Book.create!(title: "Book Test") }

  describe "#average_rating" do
    context "with enough valid reviews" do
      before do
        book.reviews.create!(rating: 5)
        book.reviews.create!(rating: 3)
        book.reviews.create!(rating: 4)
      end

      it "returns the average rating rounded to one decimal" do
        expect(book.average_rating).to eq(4.0)
      end
    end

    context "ignoring banned reviews" do
      before do
        book.reviews.create!(rating: 5, banned: false)
        book.reviews.create!(rating: 4, banned: false)
        book.reviews.create!(rating: 3, banned: true)
        book.reviews.create!(rating: 2, banned: false)
      end

      it "returns the average only from non-banned reviews" do
        expect(book.average_rating).to eq(3.7)
      end
    end

    context "with less than 3 valid reviews" do
      before do
        book.reviews.create!(rating: 5)
        book.reviews.create!(rating: 4)
      end

      it "returns 'Reseñas Insuficientes'" do
        expect(book.average_rating).to eq("Reseñas Insuficientes")
      end
    end
  end
end
