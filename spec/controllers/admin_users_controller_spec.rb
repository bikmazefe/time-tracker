require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
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
end
