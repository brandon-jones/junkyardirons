require 'mock_redis'

FactoryGirl.define do
  factory :about_my_machines do
    skip_create
    mr = MockRedis.new
    mr.set('about_my_machines', 'this is the about section')
    description mr.get 'about_my_machines'
  end
end