require "rails_helper"

RSpec.describe Entry, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:started_at) }
  it { should validate_presence_of(:entry_type) }

  describe "#duration_string" do
    it "returns the total duration of the entry with correct format" do
      start_time = DateTime.new(2021, 10, 31, 2, 2, 2, "+03:00")
      end_time = DateTime.new(2021, 10, 31, 5, 23, 10, "+03:00")
      entry = FactoryBot.create(:entry, started_at: start_time, finished_at: end_time)

      expect(entry.duration_string).to eq "03:21:08"
    end
  end

  describe ".by_user" do
    it "returns the entries for the given user(s)" do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      user3 = FactoryBot.create(:user)
      FactoryBot.create_list(:entry, 5, user: user1)
      FactoryBot.create_list(:entry, 5, user: user2)
      FactoryBot.create_list(:entry, 5, user: user3)

      expect(Entry.by_user([user1.id, user2.id])).to eq user1.entries + user2.entries
      expect(Entry.by_user([user3.id])).not_to include(user3.entries)
    end
  end

  describe ".at_between" do
    it "returns the entries between given dates" do
      entry1 = FactoryBot.create(:entry, comment: "Yesterday", started_at: DateTime.now - 1.day, finished_at: DateTime.now - 1.day + 3.hours)
      entry2 = FactoryBot.create(:entry, comment: "Today", started_at: DateTime.now, finished_at: DateTime.now + 2.hours)
      entry3 = FactoryBot.create(:entry, comment: "Tomorrow", started_at: DateTime.now + 1.day, finished_at: DateTime.now + 1.day + 2.hours)

      expect(Entry.at_between(Date.today, Date.today + 1)).to eq [entry2, entry3]
    end
  end
end
