FactoryGirl.define do 
  factory :user do 
    name "Example User"
    email "example@user.com"
    password "password"
    password_confirmation "password"

    factory :admin_user do 
      admin true 
    end
  end
end