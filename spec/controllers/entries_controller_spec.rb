require "rails_helper"

RSpec.describe EntriesController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  before :each do
    sign_in user
  end

  context "timer mode methods" do
    let(:entry_attrs) { FactoryBot.attributes_for(:entry, user: user) }

    describe "POST start" do
      it "creates and starts an entry" do
        post :start, params: { entry: entry_attrs }

        expect(Entry.last.ongoing?).to be true
      end
    end

    describe "POST finish" do
      it "finishes the ongoing entry" do
        ongoing = FactoryBot.create(:entry, started_at: Time.now - 5.minutes, user: user)

        post :finish

        expect(Entry.last.ongoing?).to be false
      end
    end
  end

  describe "POST create" do
    let(:today) { Time.new(Date.today.year, Date.today.month, Date.today.day) }
    let(:entry_attrs) { FactoryBot.attributes_for(:entry) }

    context "entry finished at same day" do
      it "sets the start and finish times before saving" do
        entry_attrs[:started_at] = today.change(hour: 13, min: 16)
        entry_attrs[:finish_time] = "13:39"

        post :create, params: { entry: entry_attrs }

        expect(Entry.last.started_at).to eq entry_attrs[:started_at]
        expect(Entry.last.finished_at).to eq today.change(hour: 13, min: 39)
      end
    end

    context "entry finished after midnight" do
      it "sets the start and finish times before saving" do
        entry_attrs[:started_at] = today.change(hour: 21, min: 18)
        entry_attrs[:finish_time] = "01:23"

        post :create, params: { entry: entry_attrs }

        expect(Entry.last.started_at).to eq entry_attrs[:started_at]
        expect(Entry.last.finished_at).to eq today.change(hour: 1, min: 23) + 1.day
      end
    end
  end
end
