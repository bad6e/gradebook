require "rails_helper"

feature "guest creates an account" do
  scenario "guest visits the login page" do
    visit root_path
    click_on "Click Here to Join"
    expect(current_path).to eq(join_path)
  end

  scenario "guest registers an account", js: true do
    visit join_path

    fill_in "user[first_name]", with: "Mickey"
    fill_in "user[last_name]", with: "Mouse"
    fill_in "user[email]", with: "mickey@disney.com"
    fill_in "user[password]", with: "mickey123"
    fill_in "user[password_confirmation]", with: "mickey123"
    select('Admin', from: "user[type]")
    click_on "Join Gradebook"

    user = User.find_by(email: "mickey@disney.com")

    expect(current_path).to eq(admin_path(user.id))

    within(".user-name") do
      expect(page).to have_content(user.full_name)
      expect(page).to have_content(user.type)
    end

    within(".user-nav-names") do
      expect(page).to have_content(user.first_name)
      expect(page).to have_content("Logout")
    end
  end

  scenario "guest must fill out form", js: true do
    visit join_path

    fill_in "user[first_name]", with: ""
    fill_in "user[last_name]", with: ""
    fill_in "user[email]", with: ""
    fill_in "user[password]", with: ""
    fill_in "user[password_confirmation]", with: ""
    select('Admin', from: "user[type]")
    click_on "Join Gradebook"

    expect(current_path).to eq(join_path)
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password confirmation can't be blank")
  end
end
