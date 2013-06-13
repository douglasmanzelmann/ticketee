require 'spec_helper'

feature "Viewing Projects" do 
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }

  before do 
    sign_in_as!(user)
    define_permission!(user, :view, project)
  end

  scenario "Listing all projects" do 
    visit '/'
    click_link project.name

    expect(page.current_url).to eql(project_url(project))
  end
end