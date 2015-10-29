require 'rails_helper'

RSpec.describe MachineSet, type: :model do

  it "can have many machines"

  it "has a description" do
    set = FactoryGirl.build(:machine_set, description: 'anything goes')
    expect(set.save).to be_truthy
  end

  it "has a price" do
    set = FactoryGirl.build(:machine_set, price: 2.99)
    expect(set.save).to be_truthy
  end

  it "requires a price" do
    set = FactoryGirl.build(:machine_set, price: nil)
    expect(set.save).to be_falsy
  end

  it "has a quantity" do
    set = FactoryGirl.build(:machine_set, quantity: 1)
    expect(set.save).to be_truthy
  end

  it "requires a quantity" do
    set = FactoryGirl.build(:machine_set, quantity: nil)
    expect(set.save).to be_falsy
  end

  it "has a image url" do
    set = FactoryGirl.build(:machine_set, image_url: 'someimage.url')
    expect(set.save).to be_truthy
  end

  it "allowes empty/nil image url" do
    set = FactoryGirl.build(:machine_set, image_url: nil)
    expect(set.save).to be_truthy
  end 

  it "requires a title" do
    set = FactoryGirl.build(:machine_set, title: nil)
    expect(set.save).to be_falsy
  end


end
