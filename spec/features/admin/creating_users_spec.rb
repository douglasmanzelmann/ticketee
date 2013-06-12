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

  scenario 'a regular user' do 
    fill_in 'Email', with: 'user@u:er.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create User'
    
    expect(page).to have_content("User has been created.")
  end

  scenario 'an admin user' do 
    fill_in 'Email', with: 'admin@user.com'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    check 'Is an admin?'
    click_button 'Create User'
    
    expect(page).to have_content("User has been created.")
    within("#users") do 
      expect(page).to have_content("admin@user.com (Admin)")
    end
  end
end