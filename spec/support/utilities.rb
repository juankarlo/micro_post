include ApplicationHelper

def valid_signin(user)
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def flash_alert(notice)
  "div.alert.alert-#{notice}"
end

RSpec::Matchers.define :have_flash_message do | notice, message|
  match do |page|
    expect(page).to have_selector(flash_alert(notice), text: message)
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
