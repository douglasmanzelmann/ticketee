require 'spec_helper'

feature 'Viewing Tickets' do 
  before do 
    user = FactoryGirl.create(:user)
    sign_in_as!(user)
    sublime_text_2 = FactoryGirl.create(:project, name: "Sublime Text 2")
    define_permission!(user, "view", sublime_text_2)

    ticket = FactoryGirl.create(:ticket, project: sublime_text_2,
                        title: "Make it shiny!",
                        description: "Isn't a joke")
    ticket.update(user: user)
    visit '/'
  end 

  scenario "Viewing tickets for a given project" do 
    click_link "Sublime Text 2"

    expect(page).to have_content("Make it shiny!")
    expect(page).to_not have_content("Standards compliance")

    click_link 'Make it shiny!'
    within("#ticket h2") do 
      expect(page).to have_content("Make it shiny")
    end

    #expect(page).to have_content("Gradients! Starburts! Oh my!")
  end
end