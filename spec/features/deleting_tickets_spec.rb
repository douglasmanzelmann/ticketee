require 'spec_helper'

feature 'Deleting Tickets' do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:ticket) do 
    ticket = FactoryGirl.create(:ticket, project: project,
                                title: "I love poop",
                                description: "It makes me feel good")
    ticket.update(user: user)
    ticket
  end

  before do
    define_permission!(user, "view", project)
    define_permission!(user, "delete tickets", project)
    sign_in_as!(user) 
    visit '/'
    click_link project.name
    click_link ticket.title 
  end

  scenario 'Deleting a ticket' do 
    click_link 'Delete Ticket'

    expect(page).to have_content("Ticket has been deleted")
    expect(page.current_url).to eq(project_url(project))
    #page 166
    expect(page).to_not have_content(ticket.title)
  end
end
