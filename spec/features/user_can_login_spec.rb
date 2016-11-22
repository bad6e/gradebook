require 'rails_helper'

feature 'Can log in as a registered user' do
  given!(:user) { create(:admin) }

  scenario 'registered user logs in' do
    visit root_path

    within('.login-buttons') do
      click_on 'Click Here to Login'
    end
    expect(current_path).to eq(login_path)

    fill_in 'login[email]', with: user.email
    fill_in 'login[password]', with: user.password
    click_button 'Login'

    expect(current_path).to eq(admin_path(user.id))

    within('.user-name') do
      expect(page).to have_content(user.full_name)
    end

    within('.user-nav-names') do
      expect(page).to have_content(user.first_name)
      expect(page).to have_content('Logout')
    end
  end

  scenario 'unregistered cannot log in' do
    visit login_path

    fill_in 'login[email]', with: 'Mickey'
    fill_in 'login[password]', with: 'Mouse'
    click_button 'Login'

    expect(page).to have_content('Invalid Login')
    expect(page).to_not have_content('Mickey')
  end

  scenario 'registered user logs in via navbar button' do
    visit root_path
    within('.user-nav-names') do
      click_link 'Login'
    end

    expect(current_path).to eq(login_path)

    fill_in 'login[email]', with: user.email
    fill_in 'login[password]', with: user.password
    click_button 'Login'

    within('.user-name') do
      expect(page).to have_content(user.full_name)
    end

    within('.user-nav-names') do
      expect(page).to have_content(user.first_name)
      expect(page).to have_content('Logout')
    end
  end

  scenario 'link to create account exists on login form' do
    visit login_path

    expect(page).to have_link('Not registered? Sign up here.')
    click_link 'Not registered? Sign up here.'

    expect(current_path).to eq(join_path)
  end

  scenario 'link to login form exists on create account' do
    visit join_path
    expect(page).to have_link('Already registered? Log in here.')

    click_link 'Already registered? Log in here.'
    expect(current_path).to eq(login_path)
  end

  scenario 'once a user logs in - they cannot vist the login path while logged in' do
    visit root_path

    within('.login-buttons') do
      click_on 'Click Here to Login'
    end
    expect(current_path).to eq(login_path)

    fill_in 'login[email]', with: user.email
    fill_in 'login[password]', with: user.password
    click_button 'Login'

    expect(current_path).to eq(admin_path(user.id))

    visit login_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content(user.full_name)

    click_on('Click Here for Profile')

    within('.user-name') do
      expect(page).to have_content(user.full_name)
    end
  end
end
