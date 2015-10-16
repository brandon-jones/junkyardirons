require 'rails_helper'

RSpec.describe AboutMyMachines, type: :model do

  it "gets description from redis" do 
    about_my_machines = FactoryGirl.create(:about_my_machines)
    expect(about_my_machines.description).to eq("this is the about section")
  end

  it "updates description from redis" do
    about_my_machines = FactoryGirl.create(:about_my_machines)
    expect(about_my_machines.description).to eq("this is the about section")
    about_my_machines.update({description: 'the new about my machines'})
    expect(about_my_machines.description).to eq('the new about my machines')
  end


  it "adds image if image is present"
  it "gets the image url from redis"

  it "knows its current image redis key" do
    about_my_machines = FactoryGirl.create(:about_my_machines)
    expect(about_my_machines.get_image_url).not_to eql(nil)
  end
  
end
