require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    context "valid params" do
      before(:each) do
        post :create, user: {username: "bob123", password: "password"}
      end

      it "creates new user" do
        expect(User.last.username).to eq("bob123")
      end

      it "redirect to goals index page" do
        expect(response).to redirect_to(goals_url)
      end
    end

    context "invalid params" do

      it "validates presence of username and password" do
        post :create, user: {username: "", password: "password"}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end

      it "validates length of password" do
        post :create, user: {username: "bob", password: "pw"}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end
  end
end
