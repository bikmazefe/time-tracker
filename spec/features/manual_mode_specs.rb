require "rails_helper"

RSpec.describe "User uses manual mode" do
  let!(:user) { FactoryBot.create(:user) }
  before :each do
    sign_in user
  end

  scenario "user creates an entry" do
    visit :profile

    find("a[href='/profile?mode=manual']").click

    expect(page).to have_current_path(profile_path(mode: "manual"))

    fill_in("entry_started_at", with: Time.now)
    fill_in("entry_finish_time", with: Time.now + 3.minute)
    select("Work", from: "entry_entry_type")

    click_on("Create")

    expect(page).to have_content("Entry created!")
  end
end
