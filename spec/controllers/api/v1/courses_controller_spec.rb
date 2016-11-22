require 'rails_helper'

RSpec.describe Api::V1::CoursesController do
  describe 'GET /api/v1/courses' do
    it 'returns all the courses' do
      5.times do
        create(:course)
      end

      get :index, format: :json
      expect(response_data.length).to eq(5)
    end
  end
end
