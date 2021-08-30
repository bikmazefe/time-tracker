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
end
