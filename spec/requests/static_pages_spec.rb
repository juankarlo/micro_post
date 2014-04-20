require 'spec_helper'

describe 'Static Pages' do
  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }

  end

  describe 'Home Page' do
    before { visit root_path }
    #it { should have_selector('h1', text: 'Micro Post') }
    #it { should have_title(full_title('')) }
    #it { should_not have_title('| Home') }
    let(:heading) { 'Micro-Post' }
    let(:page_title) { '' }

    it_should_behave_like('all static pages')
    it { should_not have_title('| Home') }

    describe "For signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user,
                           content: "Never haul a dubloon.")
        FactoryGirl.create(:micropost, user: user,
                           content: "Beauty ho! drink to be pulled.")
        sign_in user
        visit root_path
      end
      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "Follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link('0 Following', href: following_user_path(user)) }
        it { should have_link('1 Follower', href: followers_user_path(user)) }
      end

    end

  end

  describe 'Help Page' do
    before { visit help_path }
    #it { should have_selector('h1', text: 'Help') }
    #it { should have_title(full_title('Help')) }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like('all static pages')

  end

  describe 'About Page' do
    before { visit about_path }
    #it { should have_selector('h1', text: 'About Us') }
    #it { should have_title(full_title('About Us')) }
    let(:heading) { 'About Us' }
    let(:page_title) { 'About Us' }

    it_should_behave_like('all static pages')

  end

  describe 'Contact Page' do
    before { visit contact_path }
    #it { should have_selector('h1', text: 'Contact Us') }
    #it { should have_title(full_title('Contact Us')) }
    let(:heading) { 'Contact Us' }
    let(:page_title) { 'Contact Us' }

    it_should_behave_like('all static pages')
  end
  it 'should have the right links on the layout' do
    visit root_path
    click_link 'About'
    expect(page).to have_title(full_title('About'))
    click_link 'Help'
    expect(page).to have_title(full_title('Help'))
    click_link 'Contact'
    expect(page).to have_title(full_title('Contact Us'))
    click_link 'Home'
    click_link 'Sign up now!'
    expect(page).to have_title(full_title('Sign Up'))
    #click_link "Micro Post"
    #expect(page).to # fill in
  end


end
