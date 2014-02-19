require 'spec_helper'

describe ApplicationHelper do
  describe 'full_title' do
    it 'should include the page title' do
      expect(full_title('foo')).to match(/foo/)
    end
    it 'should include the base title' do
      expect(full_title('foo')).to match(/^Ruby on Rails Tutorial Sample App | foo/)
      #full_title('foo').should =~ /^Ruby on Rails Tutorial Sample App/
    end
    it 'should not include the pipe for the home page' do
      expect(full_title('')).not_to match(/\|/)
    end
  end
end