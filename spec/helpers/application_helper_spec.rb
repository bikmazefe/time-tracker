require "rails_helper"

describe ApplicationHelper do
  describe "#format_duration" do
    it "converts duration to formatted string" do
      duration = 13458 # 3 hours 44 minutes 18 seconds

      expect(helper.format_duration(duration)).to eq "03:44:18"
    end
  end
end
