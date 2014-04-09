include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
  #  Sign in when not using capybara
    remember_token =User.new_remember_token
    cookies[:remember_token] =remember_token
    user.update_attribute(:remember_token, User.hash(remember_token))
  else
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
  end
end

def flash_alert(notice)
  "div.alert.alert-#{notice}"
end

RSpec::Matchers.define :have_flash_message do | alert, message|
  match do |page|
    expect(page).to have_selector(flash_alert(alert), text: message)
  end
end



#RSpec::Matchers.define :have_error_msg do
#  match do |page|
#    expect(page).to have_selector('div.alert.alert-danger')
#  end
#end
#RSpec::Matchers.define :have_success_message do |message|
#  match do |page|
#    expect(page).to have_selector('div.alert.alert-success', text: message)
#  end
#end
