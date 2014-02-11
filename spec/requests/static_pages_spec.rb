require 'spec_helper'

describe "Static Pages" do
  describe 'Home Page' do
    it "Should have the h1 'Sample App'" do
      visit '/static_pages/home'
      page.should have_selector('h1', text: 'Sample App')
    end
    it "Should have the right title" do
      visit '/static_pages/home'
      page.should have_title('Ruby on Rails tutorial Sample App | Home')
    end
  end

  describe 'Help Page' do
    it "Should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', text: 'Help')
    end
    it "Should have the right title" do
      visit '/static_pages/help'
      page.should have_title('Ruby on Rails tutorial Sample App | Help')
    end
  end

  describe 'About Page' do
    it "Should have the h1 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', text: 'About Us')
    end
    it "Should have the right title" do
      visit '/static_pages/about'
      page.should have_title('Ruby on Rails tutorial Sample App | About Us')
    end
  end

  describe 'Contact Page' do
    it "Should have the h1 'Contact Us'" do
      visit '/static_pages/contact'
      page.should have_selector('h1', text: 'Contact Us')
    end
    it "Should have the right title" do
      visit '/static_pages/contact'
      page.should have_title('Ruby on Rails tutorial Sample App | Contact Us')
    end
  end
end
