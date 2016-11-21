require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "GET #show /students/:id" do
    context "it takes an student id and renders the show template" do

      let!(:student) { create(:student) }

      before do
        login(student)
        get :show, id: current_user.id, type: 'Student'
      end

      it "renders the show template" do
        expect(response).to render_template("students/show")
      end
    end

    context "student must be signed in" do
      before do
        get :show, id: 2, type: 'Student'
      end

      it "renders the unauthorized template" do
        expect(response).to render_template("layouts/application")
        expect(response).to_not render_template("students/show")
      end
    end

    context "student can only access their own information" do
      let!(:student1) { create(:student) }
      let!(:student2) { create(:student) }

      before do
        login(student1)
        get :show, id: student2.id, type: 'Student'
      end

      it "renders the unauthorized template" do
        expect(response).to render_template("layouts/application")
        expect(response).to_not render_template("students/show")
      end
    end
  end
end