# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "associations" do
    it { should have_many(:goals) }
  end

  describe "::find_by_credentials" do
    let(:user) { create(:user) }

    it "finds valid user" do
      expect(User.find_by_credentials(user.username, user.password).username).to eq(user.username)
    end

    it "does not find invalid user" do
      expect(User.find_by_credentials(user.username, "")).to be_nil
    end
  end
end
