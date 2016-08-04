require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:user) { create :user }

  describe "get #index" do

    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end
      it "renders goals index page" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "get #new" do
    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it "renders new goal page" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "post #create" do
    before(:each) do
      allow(controller).to receive(:current_user) { user }
    end

    context "valid params" do
      before(:each) do
        post :create, goal: {title: "sample title",
                             details: "sample details",
                             user_id: user.id}
      end

      it "creates new goal" do
        expect(Goal.last.title).to eq("sample title")
      end

      it "redirect to the goal's show page" do
        expect(response).to redirect_to(goal_url(Goal.last.id))
      end
    end

    context "invalid params" do
      it "validates presence of title, details, user" do
        post :create, goal: {title: "",
                             details: "sample details"}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
      end
    end

  end

  describe "get #edit" do
    let(:goal) { create :goal, user_id: user.id }

    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it "renders the goal's edit page" do
        get :edit, id: goal.id
        expect(response).to render_template(:edit)
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirects to the login page" do
        get :edit, id: goal.id
        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "patch #update" do
    let(:user2) { create :user }
    let(:goal) { create :goal, user_id: user.id }

    before do
      allow(controller).to receive(:current_user) { user2 }
    end

    it "should not allow you to edit another users goals" do
      begin
        patch :update, id: goal.id, goal: { title: "something else" }
      rescue ActiveRecord::RecordNotFound
      end
      updated_goal = Goal.find(goal.id)
      expect(updated_goal.title).not_to eq("something else")
    end
  end

  describe "delete #destroy" do
    let(:goal) { create :goal, user_id: user.id }

    context "when logged in" do
      before do
        allow(controller).to receive(:current_user) { user }
      end

      it "should delete goal" do
        delete :destroy, id: goal.id
        expect(Goal.exists?(goal.id)).to be false
        expect(response).to redirect_to(goals_url)
      end
    end

    context "when logged out" do
      before do
        allow(controller).to receive(:current_user) { nil }
      end

      it "redirects to the login page" do
        delete :destroy, id: goal.id
        expect(response).to redirect_to(new_session_url)
      end
    end
  end
end
