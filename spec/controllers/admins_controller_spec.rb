require 'rails_helper'

RSpec.describe AdminsController, type: :controller do
  describe 'GET #show /admins/:id' do
    context 'it takes an admin id and renders the show template' do
      let!(:admin) { create(:admin) }

      before do
        login(admin)
        get :show, id: current_user.id, type: 'Admin'
      end

      it 'renders the show template' do
        expect(response).to render_template('admins/show')
      end
    end

    context 'admin must be signed in' do
      before do
        get :show, id: 2, type: 'Admin'
      end

      it 'renders the unauthorized template' do
        expect(response).to render_template('layouts/application')
        expect(response).to_not render_template('admins/show')
      end
    end

    context 'admin can only access their own information' do
      let!(:admin1) { create(:admin) }
      let!(:admin2) { create(:admin) }

      before do
        login(admin1)
        get :show, id: admin2.id, type: 'Admin'
      end

      it 'renders the unauthorized template' do
        expect(response).to render_template('layouts/application')
        expect(response).to_not render_template('admins/show')
      end
    end
  end
end
