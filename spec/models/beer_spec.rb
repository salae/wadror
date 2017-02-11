require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "with a name and style set correctly is created and saved" do
    beer = Beer.new name: "olut1", style: "lager"

    expect(beer.name).to eq("olut1")
    expect(beer.style).to eq("lager")

    expect(beer).to be_valid

    beer.save

    expect(Beer.count).to eq(1)
  end 

  it "is not saved without a name" do
    beer = Beer.new style: "lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end 

  it "and is not saved without a style" do
    beer = Beer.new name: "olut1"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end 
end
