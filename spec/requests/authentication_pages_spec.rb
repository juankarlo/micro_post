require 'spec_helper'

describe 'Authentication' do
  subject { page }
  describe 'Sign in page' do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe 'Sign in' do
    before { visit signin_path }

    describe 'With invalid information' do
      before { click_button 'Sign in' }
      it { should have_title('Sign in') }
      it { should have_flash_message('danger', 'Invalid') }
      describe 'After visiting another page' do
        before { click_link 'Home' }
        it { should_not have_selector(flash_alert('danger')) }
        #it { should_not flash_message('danger') }
      end

    end

    describe 'With valid information' do
      let(:user) { FactoryGirl.create(:user) }

      before { valid_signin(user) }

      it { should have_title(user.name) }
      #xit { should have_link('Users',       href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe 'After visiting Home page' do
        before { click_link 'Home' }
        it { should_not have_link('Sign up now!', href: signup_path) }
      end

      describe 'Followed by signout' do
        before { click_link 'Sign out' }
        it { should have_link('Sign in') }

      end

    end

  end


end
