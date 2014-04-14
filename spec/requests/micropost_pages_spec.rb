require 'spec_helper'

describe 'Micropost pages' do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'Micropost creation' do
    before { visit root_path }
    describe 'with invalid information' do
      it 'should not create a micropost' do
        expect { click_button 'Post' }.not_to change(Micropost, :count)
      end
      describe 'error message' do
        before { click_button 'Post' }
        # xit { should have_flash_message('danger') }

      end

    end

    describe 'with valid information' do
      before { fill_in 'micropost_content', with: 'Where is the extraterrestrial AEevacuatefutile unit?' }
      it 'should create a micropost' do
        expect { click_button 'Post' }.to change(Micropost, :count).by(1)
      end
    end


  end

  describe "Micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }
      it 'should delete a micropost' do
        expect { click_link 'Delete' }.to change(Micropost, :count).by(-1)

      end
    end

  end


end
