require "rails_helper"
require "./spec/support/date_helpers"

RSpec.configure do |c|
  c.include DateHelpers
end

RSpec.describe Entry, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:entry_type) }

  context "timer mode" do
    let!(:entry) { FactoryBot.create(:entry) }

    describe "#start!" do
      it "creates a entry and sets started_at to current time" do
        entry.start!

        expect(format_date(entry.started_at)).to eq format_date(Time.now)
      end
    end

    describe "#finish!" do
      it "sets finished_at attr of ongoing entry" do
        entry.update(started_at: Time.now - 3.minutes)
        entry.finish!

        expect(format_date(entry.finished_at)).to eq format_date(Time.now)
      end
    end
  end

  describe "#duration" do
    it "returns the total duration of the entry with correct format" do
      start_time = DateTime.new(2021, 10, 31, 2, 2, 2)
      end_time = DateTime.new(2021, 10, 31, 5, 23, 10)
      entry = FactoryBot.create(:entry, started_at: start_time, finished_at: end_time)

      expect(entry.duration).to eq 12068
    end
  end

  describe ".total_duration" do
    let!(:entry1) { FactoryBot.create(:entry, started_at: DateTime.new(2021, 8, 12, 9, 20, 30), finished_at: DateTime.new(2021, 8, 12, 10, 30, 30)) } # Duration 4200 sec
    let!(:entry2) { FactoryBot.create(:entry, started_at: DateTime.new(2021, 8, 16, 7), finished_at: DateTime.new(2021, 8, 16, 9, 20, 35)) } #Duration 8435

    it "returns the total duration of user's entries" do
      expect(Entry.total_duration).to eq 12635
    end
  end

  describe ".count_by_type" do
    it "returns the number of entries with the given type" do
      FactoryBot.create_list(:entry, 5, entry_type: "Work")
      FactoryBot.create_list(:entry, 5, entry_type: "Personal")

      expect(Entry.count_by_type("Work")).to eq 5
      expect(Entry.count_by_type("Personal")).to eq 5
    end
  end

  describe ".at_between" do
    it "returns the entries between given dates" do
      entry1 = FactoryBot.create(:entry, comment: "Yesterday", started_at: DateTime.new(2021, 8, 10, 11), finished_at: DateTime.new(2021, 8, 10, 12))
      entry2 = FactoryBot.create(:entry, comment: "Today", started_at: DateTime.new(2021, 8, 13, 15), finished_at: DateTime.new(2021, 8, 13, 16))
      entry3 = FactoryBot.create(:entry, comment: "Tomorrow", started_at: DateTime.new(2021, 8, 14, 15), finished_at: DateTime.new(2021, 8, 13, 17))

      expect(Entry.at_between(Date.new(2021, 8, 13), Date.new(2021, 8, 14))).to eq [entry2, entry3]
    end
  end
end
