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

      before { sign_in(user) }

      it { should have_title(user.name) }
      it { should have_link('Users', href: users_path) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) }
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


  describe 'Authorization' do

    describe 'For non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'When attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          sign_in user
        end

        describe 'After Sign in' do
          it 'should render the desired protected page' do
            expect(page).to have_title('Edit user')
          end

          describe 'When signin in again' do
            before do
              click_link 'Sign out'
              visit signin_path
              sign_in user
            end
            it 'should render the default Profile page' do
              expect(page).to have_title(user.name)
            end
          end

        end

      end


      describe 'In the Users controller' do

        describe 'Visiting the edit page' do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
          it { should have_flash_message('warning', 'Please sign in') }
        end

        describe 'Submitting to the update action' do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe 'Visiting the users index' do

          before { visit users_path }
          it { should have_title('Sign in') }

        end


      end


    end

    describe 'As Wrong user' do

      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }
      before { sign_in user, no_capybara: true }

      describe 'Submitting a GET request to the Users#edit action' do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_path) }

      end

      describe 'Submitting a PATCH request to the User#update action' do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }

      end


    end

    describe 'As non-admin user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }
      describe 'Submitting a DELETE request to the Users#destroy action' do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_path) }

      end


    end

    describe 'As admin user' do
      let(:admin) { FactoryGirl.create(:admin) }

      before { sign_in admin, no_capybara: true }

      describe 'Submitting a self DELETE request' do
        before { delete user_path(admin) }
        specify { expect(response).to redirect_to(users_path) }
        #specify { expect(response.body).to match(full_title('All users')) }

      end


    end


  end # End Authorization


end
