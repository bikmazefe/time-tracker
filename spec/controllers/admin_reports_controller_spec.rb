require "rails_helper"

RSpec.describe Admin::ReportsController, type: :controller do
  before :each do
    admin = FactoryBot.create(:user, admin: true)
    sign_in admin
  end

  let!(:user1) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }

  describe "GET index" do
    context "format csv" do
      it "renders csv template" do
        get :index, format: :csv

        expect(response).to render_template("index.csv.haml")
      end
    end
    context "format xlsx" do
      it "renders xlsx template" do
        get :index, format: :xlsx

        expect(response).to render_template("index.xlsx.axlsx")
      end
    end
  end

  describe "#set_selected_users" do
    context "user_ids param exists" do
      it "assigns @selected_users" do
        get :index, params: { q: { user_ids: [user1.id] } }

        expect(assigns(:selected_users)).to eq [user1]
      end
    end
    context "user_ids param do not exist" do
      it "assigns @selected_users" do
        get :index

        expect(assigns(:selected_users)).to eq User.without_admins
      end
    end
  end
end
