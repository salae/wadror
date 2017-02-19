require 'rails_helper'

include Helpers

describe "User" do  
  let!(:user) { FactoryGirl.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end 
  end
    
  it "when signed up with good credentials, is added to the system" do
        visit signup_path
        fill_in('user_username', with:'Brian')
        fill_in('user_password', with:'Secret55')
        fill_in('user_password_confirmation', with:'Secret55')

        expect{
        click_button('Create User')
        }.to change{User.count}.by(1)
    end  

 describe "when have given ratings" do
    before :each do
      s1 = FactoryGirl.create :style, name: "helles" 
      s2 = FactoryGirl.create :style, name: "bock" 
      brew = FactoryGirl.create :brewery, name:"Schlenkerla"     
      create_beers_with_ratings(user, s1,FactoryGirl.create(:brewery),10, 7, 9,12,14)
      create_beers_with_ratings(user, s2, brew, 10,42,33,41,24,11)
      user2 = FactoryGirl.create(:user, username: "Brian")
      create_beers_with_ratings(user2, s1, brew, 50)
      visit user_path(user.id)
    end

    it "those are listed at users page" do
      expect(page).to have_content "anonymous 10"
      expect(page).to have_content "anonymous 7"
      expect(page).to have_content "anonymous 9"
    end

    it "only those are listed at users page" do
      expect(page).to have_no_content "anonymous 50"
    end 

    it "when logged in, can delete own ratings" do
      sign_in(username:"Pekka", password:"Foobar1")
      visit user_path(user.id)      
      expect{
        page.all('a')[13].click
      }.to change{Rating.count}.by(-1)
    end  

    it "favorite style is shown at user page" do
      expect(page).to have_content "Favorite style: bock"  
    end 

    it "favorite brewery is shown at user page" do
      expect(page).to have_content "Favorite brewery: Schlenkerla"  
    end     
  end
end
def create_beer_with_rating(user, style, brewery, score)
  beer = FactoryGirl.create(:beer, style: style, brewery: brewery)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(user, style, brewery, *scores)
  scores.each do |score|
    create_beer_with_rating(user, style, brewery, score)
  end
end