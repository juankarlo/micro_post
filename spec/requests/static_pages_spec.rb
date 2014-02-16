require 'spec_helper'


describe "Static Pages" do
  subject { page }
  describe 'Home Page' do
    before { visit root_path }
    it { should have_content('Sample App') }
    #it "Should have the content 'Sample App'" do
    #  expect(page).to have_selector('h1', text: 'Sample App')
    #end

    it { should have_title(full_title('')) }
    #it "Should have the base title" do
    #  expect(page).to have_title('Ruby on Rails tutorial Sample App')
    #end

    it { should_not have_title('| Home') }
    #it "Should not have a custom page title" do
    #  expect(page).not_to have_title('| Home')
    #end

  end

  describe 'Help Page' do
    before { visit help_path }
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe 'About Page' do
    before { visit about_path }
    it { should have_content('About Us') }
    it { should have_title(full_title('About Us')) }

  end

  describe 'Contact Page' do
    before { visit contact_path }
    it { should have_content('Contact Us') }
    it { should have_title(full_title('Contact Us')) }

  end

end
