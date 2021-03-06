require 'rails_helper'
include LoginHelper

describe 'User' do
  describe 'who has registered' do
    let(:user) { FactoryGirl.create(:user) }

    it 'can log in' do
      visit new_session_path
      fill_in('name', with: user.name)
      fill_in('password', with: user.password)
      click_button('Log in')
      expect(page).to have_content("You've logged in.")
    end

    context 'with wrong letter case on name' do
      it 'can log in' do
        visit new_session_path
        fill_in('name', with: user.name.upcase)
        fill_in('password', with: user.password)
        click_button('Log in')
        expect(page).to have_content("You've logged in.")
      end
    end

    it 'cannot log in with incorrect password' do
      visit new_session_path
      fill_in('name', with: user.name)
      fill_in('password', with: 'wrong')
      click_button('Log in')
      expect(page).to have_content('Username and password do not match.')
    end

    describe 'who has logged in' do
      before :each do
        log_in(name: user.name, password: user.password)
      end

      it 'can log out' do
        visit root_path
        click_link('Log out')
        expect(page).to have_content('Log in')
      end
    end
  end

  context "who hasn't registered" do
    it 'can register' do
      visit new_user_path
      fill_in('user_name', with: 'name')
      fill_in('user_password', with: 'secret')
      fill_in('user_password_confirmation', with: 'secret')
      click_button('Create User')
      expect(page).to have_content('User was successfully created.')
    end
  end
end
