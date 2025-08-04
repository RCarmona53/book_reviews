RSpec.describe Review, type: :model do
  let(:book) { Book.create!(title: "Book Test") }

  context "rating validations" do
    it "is valid with a rating from 1 to 5" do
      (1..5).each do |r|
        expect(book.reviews.build(rating: r)).to be_valid
      end
    end

    it "is invalid with a rating outside 1 to 5" do
      [0, 6, 10, -1].each do |r|
        expect(book.reviews.build(rating: r)).not_to be_valid
      end
    end
  end

  context "content validations" do
    it "is valid without content" do
      expect(book.reviews.build(rating: 3, content: nil)).to be_valid
    end

    it "is invalid if content exceeds 1000 characters" do
      expect(book.reviews.build(rating: 3, content: "a" * 1001)).not_to be_valid
    end
  end

  context "default values" do
    it "defaults to not banned" do
      review = book.reviews.create!(rating: 4)
      expect(review.banned).to eq(false)
    end
  end
end
