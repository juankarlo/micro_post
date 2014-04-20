require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe 'Index' do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do

      #sign_in FactoryGirl.create(:user)
      #FactoryGirl.create(:user, name: 'Bob', email: 'bob@example.com')
      #FactoryGirl.create(:user, name: 'Ben', email: 'ben@example.com')
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_content('All users') }

    describe 'Pagination' do
      before(:all) { 4.times { FactoryGirl.create(:user) } }
      after(:all) { User.delete_all }

      it { should have_selector('div.pagination') }

      it 'should list each user' do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li>a', text: user.name)
        end
      end
    end

    describe 'Delete links' do

      it { should_not have_link('delete') }

      describe 'As an Admin user' do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('Delete', href: user_path(User.first)) }
        it 'should be able to delete another user' do
          expect do
            click_link('Delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('Delete', href: user_path(admin)) }
      end
    end
  end

  describe 'Profile page' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "All protons transfer distant, small sonic showers.") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "I assimilate this voyage, it's called futile rumour.") }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }

    describe 'Microposts' do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

    describe 'Follow/unfollow buttons' do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe 'Following a user' do
        before { visit user_path(other_user) }

        it 'should increment the followed user count' do
          expect do
            click_button 'Follow'
          end.to change(user.followed_users, :count).by(1)
        end
        it "should increment the other user's followers count" do
          expect do
            click_button 'Follow'
          end.to change(other_user.followers, :count).by(1)
        end

        describe 'Toggling the button' do
          before { click_button 'Follow' }
          it { should have_xpath("//input[@value='Unfollow']") }
        end

      end

      describe 'Unfollowing a user' do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it 'should decrement the followed user count' do
          expect do
            click_button 'Unfollow'
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button 'Unfollow'
          end.to change(other_user.followers, :count).by(-1)
        end

        describe 'Toggling the button' do
          before { click_button 'Unfollow' }
          it { should have_xpath("//input[@value='Follow']") }

        end

      end

    end

  end

  describe 'Signup Page' do
    before { visit signup_path }
    it { should have_content('Sign Up') }
    it { should have_title(full_title('Sign Up')) }
  end

  describe 'Signup' do
    before { visit signup_path }
    let(:submit) { 'Create my Account' }

    describe 'With invalid information' do
      it 'Should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'After submision' do
        before { click_button submit }
        it { should have_title('Sign Up') }
        it { should have_content('error') }
      end
    end

    describe 'With valid information' do
      before do
        fill_in 'Name', with: 'Example User'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'foobar'
        fill_in 'Confirmation', with: 'foobar'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe 'After saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        #it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_flash_message('success', 'Welcome') }
      end
    end
  end

  describe 'Edit' do
    let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe 'Page' do
      it { should have_content('Update your profile') }
      it { should have_title('Edit user') }
      it { should have_link('Change', href: 'http://gravatar.com/emails') }
    end
    describe 'With invalid information' do
      before { click_button 'Save changes' }
      it { should have_content('error') }
    end

    describe 'With valid information' do
      let(:new_name) { 'New Name' }
      let(:new_email) { 'new_email@example.com' }
      before do
        fill_in 'Name', with: new_name
        fill_in 'Email', with: new_email
        fill_in 'Password', with: user.password
        fill_in 'Confirmation', with: user.password
        click_button 'Save changes'
      end
      it { should have_title(new_name) }
      it { should have_flash_message('success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.name).to eq new_name }
      specify { expect(user.reload.email).to eq new_email }

    end

    describe 'Forbidden attributes' do
      let(:params) do
        {user: {admin: true, password: user.password, password_confirmation: user.password}}
      end

      before do
        sign_in user, no_capuybara: true
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end


  end

  describe 'following/followers' do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe 'Followed users' do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_title(full_title('Following')) }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe 'Follower' do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_title(full_title('Followers')) }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end

end
