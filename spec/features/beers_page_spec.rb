require 'rails_helper'

include Helpers

describe "Beer" do
 

   describe "after user has signed in" do
    before :each do
        FactoryGirl.create :user
        sign_in(username:"Pekka", password:"Foobar1")
    end   

    it "can be added using the web form when valid name for beer is given" do
        visit new_beer_path
        fill_in('beer_name', with:'Olut I')

        expect{
        click_button('Create Beer')
        }.to change{Beer.count}.by(1)
    end

    it "is not created when name field is left empty " do
        visit new_beer_path

        expect{
        click_button('Create Beer')
        }.to change{Beer.count}.by(0)

        expect(page).to have_content 'Name can\'t be blank'
    end
  end
end
