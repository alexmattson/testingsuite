require "spec_helper"
require "rails_helper"

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    scenario "shows username on the homepage after signup" do
      create_valid_user
      expect(page).to have_content "testing_username"
    end

  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    log_in_valid_user
    expect(page).to have_content "testing_username"
  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit goals_url
    expect(page).to have_buttond("Log Out")
  end

  scenario "doesn't show username on the homepage after logout" do
    log_in_valid_user
    log_out
    expect(page).not_to have_content("testing_username")
  end
end
