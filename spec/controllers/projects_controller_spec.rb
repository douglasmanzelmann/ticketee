require 'spec_helper'

describe ProjectsController do 
  let(:user) { FactoryGirl.create(:user) } 

  context "standard users" do 
    before(:each) { sign_in(user) }

    { new: :get,
      create: :post,
      edit: :get,
      update: :put,
      destroy: :delete }.each do |action, method|
        it "cannot access the #{action} action" do 
          sign_in(user)
          send(method, action, id: FactoryGirl.create(:project))
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eql("You must be an admin to do that.")
        end
      end
    end

    it "cannot access the show action without permission" do
      sign_in(user) 
      project = FactoryGirl.create(:project)
      get :show, id: project.id

      expect(response).to redirect_to(projects_path)
      expect(flash[:alert]).to eql("The project you were looking for " + 
                                   "could not be found.")
    end
end