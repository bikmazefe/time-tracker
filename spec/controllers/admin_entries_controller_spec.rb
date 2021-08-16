require "rails_helper"

RSpec.describe Admin::EntriesController, type: :controller do
  before :each do
    admin = FactoryBot.create(:user, admin: true)
    sign_in admin
  end

  describe "#set_user_ids" do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }
    context "user_ids param exists" do
      it "assigns @user_ids" do
        get :index, params: { q: { user_ids: [user1.id] } }

        expect(assigns(:user_ids)).to eq [user1.id.to_s]
      end
    end
    context "user_ids param do not exist" do
      it "assigns @user_ids" do
        get :index

        expect(assigns(:user_ids)).to eq [user1.id, user2.id]
      end
    end
  end
end
