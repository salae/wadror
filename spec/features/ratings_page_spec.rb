require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
end

describe "Ratings page" do
  it "lists ratings and their number" do
    ratings = create_ratings(20,15,10,41,26)
    visit ratings_path

    expect(page).to have_content "Number of ratings: #{ratings.count}"
    ratings.each do |rating_name|
      expect(page).to have_content rating_name
    end     
  end
end 

def create_ratings(*scores)
  s = 'b'
  user = FactoryGirl.create(:user)
  scores.each do |score|
    beer = FactoryGirl.create(:beer, name: s += 'a' )
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  end
end