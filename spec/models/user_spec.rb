require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "associations" do

  end

  describe "::find_by_credentials" do
    let(:user) { create(:user) }

    it "finds valid user" do
      expect(User.find_by_credentials(user.username, user.password)).to be(user)
    end

    it "does not find invalid user" do
      expect(User.find_by_credentials(user.username, "")).not_to be(user)
    end
  end
end
