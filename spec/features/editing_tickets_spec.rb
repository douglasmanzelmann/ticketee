require 'spec_helper'

feature "Editing Tickets" do 
  let!(:project) { FactoryGirl.create(:project, name: "Sublime Text 2") }
  let!(:ticket) { FactoryGirl.create(:ticket, project: project,
                        title: "I love poop",
                        description: "It makes me feel good") }

  before do 
    visit '/'
    click_link 'Sublime Text 2'
    click_link 'I love poop'
    click_link 'Edit Ticket'
  end

  scenario "with valid information" do \
    fill_in 'Description', with: "It's very, very refreshing"
    click_button 'Update Ticket'

    expect(page).to have_content("Ticket has been updated")
    
    within('#ticket h2') do 
      expect(page).to have_content("I love poop")
    end
    
    expect(page).to_not have_content("It makes me feel good")
  end

  scenario "with invalid information" do 
    fill_in 'Description', with: ''
    click_button 'Update Ticket'

    expect(page).to have_content("Ticket has not been updated")
    #expect(page).to have_content("Description can't be blank")
  end
end