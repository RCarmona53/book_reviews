require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:book) { Book.create!(title: "El Quijote") }

  it "is valid with a rating from 1 to 5" do
    (1..5).each do |r|
      review = book.reviews.build(rating: r)
      expect(review).to be_valid
    end
  end

  it "is invalid with a rating outside 1 to 5" do
    [0, 6, 10, -1].each do |r|
      review = book.reviews.build(rating: r)
      expect(review).not_to be_valid
    end
  end

  it "is valid without content" do
    review = book.reviews.build(rating: 3, content: nil)
    expect(review).to be_valid
  end

  it "is invalid if content exceeds 1000 characters" do
    review = book.reviews.build(rating: 3, content: "a" * 1001)
    expect(review).not_to be_valid
  end

  it "defaults to not banned" do
    review = book.reviews.create!(rating: 4)
    expect(review.banned).to eq(false)
  end
end
