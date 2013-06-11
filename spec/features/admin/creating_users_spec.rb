require 'spec_helper'

feature "Creating Users" do 
  let!(:admin) { FactoryGirl.create(:admin_user) }

  before do 
    sign_in_as!(admin)
    visit '/'
    click_link 'Admin'
    click_link 'Users'
    click_link 'New User'
  end

  scenario 'with valid information' do 
    fill_in 'Email', with: 'user@user.com'
    fill_in 'user_password', with: 'password'
    click_button 'Create User'
    expect(page).to have_content("User has been created.")
  end
end