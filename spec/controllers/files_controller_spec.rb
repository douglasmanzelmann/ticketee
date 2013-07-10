require 'spec_helper'

describe FilesController do
  let(:user_with_permission) { FactoryGirl.create(:user) } 
  let(:user_without_permission) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket) { FactoryGirl.create(:ticket, project: project, 
                                    user: user_with_permission) }
  let(:path) { Rails.root + "spec/fixtures/speed.txt" }
  let(:asset) do 
    ticket.assets.create(asset: File.open(path))
  end 

  before do 
    user_with_permission.permissions.create!(action: "view", thing: project)
  end

  context "without permission" do 
    before do 
      sign_in(user_without_permission)
    end

    it "cannot access assets in a project" do 
      get 'show', id: asset.id 
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The asset you were looking for could not be found.")
    end
  end

  context "with permission" do 
    before do 
      sign_in(user_with_permission)
    end

    it "can access assets in a project" do 
      get 'show', id: asset.id 
      expect(response.body).to eql(File.read(path))
    end

  end 

end
