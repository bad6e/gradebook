require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  describe "GET #show /teacher/:id" do
    context "it takes an teacher id and renders the show template" do

      let!(:teacher) { create(:teacher) }

      before do
        login(teacher)
        get :show, id: current_user.id, type: 'Teacher'
      end

      it "renders the show template" do
        expect(response).to render_template("teachers/show")
      end
    end

    context "teacher must be signed in" do
      before do
        get :show, id: 2, type: 'Teacher'
      end

      it "renders the unauthorized template" do
        expect(response).to render_template("layouts/application")
        expect(response).to_not render_template("teachers/show")
      end
    end

    context "teacher can only access their own information" do
      let!(:teacher1) { create(:teacher) }
      let!(:teacher2) { create(:teacher) }

      before do
        login(teacher1)
        get :show, id: teacher2.id, type: 'Teacher'
      end

      it "renders the unauthorized template" do
        expect(response).to render_template("layouts/application")
        expect(response).to_not render_template("teachers/show")
      end
    end
  end
end
