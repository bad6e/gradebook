require 'rails_helper'

RSpec.describe Api::V1::SemestersController do
  describe "GET /api/v1/semesters" do

    it "returns all the semesters with semester name" do
      5.times do
        create(:semester)
      end

      get :index, format: :json
      expect(response_data.length).to eq(5)
      expect(response_data[0].has_key?(:semesterName)).to eq(true)
    end
  end
end