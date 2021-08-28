require "rails_helper"

RSpec.describe "User uses timer mode" do
  let!(:user) { FactoryBot.create(:user) }
  before :each do
    sign_in user
  end

  scenario "user starts the timer" do
    visit :profile

    select("Work", from: "entry_entry_type")
    click_on("Start")

    expect(page).to have_content "Entry started!"
  end

  scenario "user stops the timer" do
    entry = FactoryBot.create(:entry, entry_type: "Work", started_at: Time.now - 2.minutes, user: user)

    visit :profile
    click_on("Finish")

    expect(page).to have_content "Entry completed!"
  end
end
