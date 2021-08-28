require "rails_helper"

describe ApplicationHelper do
  describe "#format_duration" do
    it "converts duration to formatted string" do
      duration = 13458 # 3 hours 44 minutes 18 seconds

      expect(helper.format_duration(duration)).to eq "03:44:18"
    end
  end
  describe "#get_entry_range" do
    it "returns a string with the start and finish time of the entry" do
      entry = FactoryBot.create(:entry, started_at: Time.new(2021, 8, 28, 13, 36), finished_at: Time.new(2021, 8, 28, 13, 44))

      expect(helper.get_entry_range(entry)).to eq "13:36 - 13:44"
    end
  end
end
