require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:entries) }

  describe "#entry_count_by_type" do
    it "returns the number of entries with the given type" do
      user = FactoryBot.create(:user)
      FactoryBot.create_list(:entry, 5, user: user, entry_type: "Business")
      FactoryBot.create_list(:entry, 5, user: user, entry_type: "Personal")

      expect(user.entry_count_by_type("Business")).to eq 5
      expect(user.entry_count_by_type("Personal")).to eq 5
    end
  end
  describe "#total_entry_duration" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:entry1) { FactoryBot.create(:entry, user: user, started_at: DateTime.new(2021, 8, 12, 9, 20, 30), finished_at: DateTime.new(2021, 8, 12, 10, 30, 30)) } # Duration 4200 sec
    let!(:entry2) { FactoryBot.create(:entry, user: user, started_at: DateTime.new(2021, 8, 16, 7), finished_at: DateTime.new(2021, 8, 16, 9, 20, 35)) } #Duration 8435

    it "returns the total duration of user's entries" do
      expect(user.total_entry_duration).to eq 12635
    end

    context "time period given" do
      it "returns the total duration of entries within the given period" do
        expect(user.total_entry_duration(DateTime.new(2021, 8, 14), DateTime.new(2021, 8, 18))).to eq 8435
      end
    end
  end
end
