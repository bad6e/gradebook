def login(user)
  request.session[:user_id] = user.id
end

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def log_in_as(user)
  visit root_path

  within(".login-buttons") do
    click_on "Click Here to Login"
  end

  fill_in "login[email]", with: user.email
  fill_in "login[password]", with: user.password
  click_button "Login"
end