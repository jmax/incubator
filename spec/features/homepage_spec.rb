require "spec_helper"

feature "Homepage" do
  scenario "presenting welcome message" do
    visit root_path

    expect(page).to have_content("Welcome to Incubator")
  end
end
