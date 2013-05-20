require 'spec_helper'

feature "Profile page" do 
  scenario "viewing" do 
    user = FactoryGirl.create(:user)

    visit user_path(user)

    expect(page).to have_content(user.name)
    expect(page).to have_content(user.email)
  end
end

feature "editing" do 
  scenario "updating a user" do 
    user = FactoryGirl.create(:user)

    visit user_path(user)
    click_link 'Edit Profile'

    fill_in 'Username', with: "New Username"
    click_button "Update User"

    expect(page).to have_content("Profile has been updated")
    expect(page).to have_content("New Username") 
  end
end
