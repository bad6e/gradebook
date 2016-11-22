require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create /join' do
    context 'it creates a new user' do
      let :credentials do
        { first_name: 'Bricelyn',
          last_name: 'Jones',
          email: 'myteaisgood@gmail.com',
          type: 'Teacher',
          password: '12345678',
          password_confirmation: '12345678' }
      end

      before :each do
        post :create, { user: credentials }, type: 'Teacher'
      end

      it 'creates a user session' do
        teacher = Teacher.first
        expect(session[:user_id]).to eq(teacher.id)
      end
    end

    context 'it renders the new template with invalid information' do
      let :credentials do
        { first_name: 'Bricelyn',
          last_name: 'Jones',
          email: 'myteaisgood@gmail.com',
          type: 'Teacher',
          password: '12345678',
          password_confirmation: '12345670' }
      end

      before :each do
        post :create, { user: credentials }, type: 'Teacher'
      end

      it 'renders the new template' do
        expect(response).to render_template('users/new')
      end
    end
  end
end
