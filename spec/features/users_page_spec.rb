require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

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
    
    it "when signed up with good credentials, is added to the system" do
        visit signup_path
        fill_in('user_username', with:'Brian')
        fill_in('user_password', with:'Secret55')
        fill_in('user_password_confirmation', with:'Secret55')

        expect{
        click_button('Create User')
        }.to change{User.count}.by(1)
    end  

    describe "who has made ratings" do

      it "can see his/her own ratings on his/her own page but doesn't see other people's ratings " do
        user= FactoryGirl.create(:user, username: "Tiina")
        sign_in(username:"Tiina", password:"Foobar1")
        ratings = create_ratings('b', user, 24, 12, 45)    

        user2= FactoryGirl.create(:user, username: "Laura")
        ratings2 = create_ratings('d',user2, 8, 35)
        visit user_path(user)

        ratings.each do |rating_name|
          expect(page).to have_content rating_name        
        end 
        ratings2.each do |rating_name|
          expect(page).not_to have_content rating_name        
        end           
      end

      it "can delete his/her own rating" do
        count_before = Rating.count

        #page.find("a:eq(2)").click_link('delete')

        # if(page.find("a")[:href] == "/ratings/1")
        #     click_on("delete")
        # end
       # expect(Rating.count).to eq(count_before - 1)
      end
    end
  end
end

def create_ratings(str, user, *scores)
  
  scores.each do |score|
    beer = FactoryGirl.create(:beer, name: str.concat('a'))
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    #binding.pry
  end
end