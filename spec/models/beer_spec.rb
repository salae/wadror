require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "with a name and style set correctly is created and saved" do
    style = Style.new name: "lager"
    beer = Beer.new name: "olut1", style: style

    expect(beer.name).to eq("olut1")
    expect(beer.style.name).to eq("lager")

    expect(beer).to be_valid

    beer.save

    expect(Beer.count).to eq(1)
  end 

  it "is not saved without a name" do
    style = Style.new name: "lager"
    beer = Beer.new style: style

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end 

  it "and is not saved without a style" do
    beer = Beer.new name: "olut1"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end 
end
