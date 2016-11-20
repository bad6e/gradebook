require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST #create /login" do
    context "it creates a session with valid credentials" do
      let :credentials do
        { email: 'myteaisgood@gmail.com', password: '12345678' }
      end

      let!(:admin) { create(:admin, credentials) }

      before :each do
        post :create, { login: credentials }, type: 'Admin'
      end

      it "creates a user session" do
        expect(session[:user_id]).to eq(admin.id)
      end
    end

    context "it renders the new template with invalid credentials" do
      let :credentials do
        { email: 'myteaisgood@gmail.com', password: '12345678' }
      end

      let!(:admin) { create(:admin, credentials) }

      before :each do
        post :create, { login: { email: 'myteaisgood@gmail.com', password: '12345679' } }, type: 'Admin'
      end

      it "renders the new template" do
        expect(response).to render_template("sessions/new")
      end
    end
  end

  describe "POST #destroy /logout" do
    context "it clears the session when a user logs out" do

      let!(:admin) { create(:admin) }

      before :each do
        login(admin)
        delete :destroy
      end

      it "destroys user session" do
        expect(session[:user_id]).to eq(nil)
      end
    end
  end
end
