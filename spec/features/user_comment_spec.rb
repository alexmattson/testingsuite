require "spec_helper"
require "rails_helper"

feature "user show page" do
  let(:user) { create :user }

  scenario "has a comment section" do
    create_valid_user
    visit user_url(User.last)
    expect(page).to have_content "Add Comment"
  end

  scenario "renders comment when comment is added" do
    create_valid_user_comment(user)
    expect(page).to have_content "testing user comment"
  end

  scenario "has option to delete comment if author" do
    create_valid_user_comment(user)
    expect(page).to have_content "Delete Comment"
  end
end
