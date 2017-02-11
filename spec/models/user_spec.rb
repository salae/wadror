require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it"is not saved without a password" do
    user = User.create username:"Pekka"

    #expect(user.valid?).to be(false)
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "and is not saved with a too short password" do
    user = User.create username:"Pekka" , password:"Sc1", password_confirmation:"Sc1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end 

  it "and is not saved with a password containing only letters" do
    user = User.create username:"Pekka" , password:"Secret", password_confirmation:"Secret"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end 

  describe "with a proper password" do
    let(:user){ User.create username: "Pekka", password:"Secret1", password_confirmation:"Secret1"}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
end
