require 'rails_helper'

RSpec.describe PenetrationsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #dynamic" do
    it "returns http success" do
      get :dynamic
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #preset" do
    it "returns http success" do
      get :preset
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #with_param" do
    it "returns http success" do
      get :with_param
      expect(response).to have_http_status(:success)
    end
  end

end
