require 'rails_helper'

describe 'a user' do
  describe 'visiting the splash page' do
    it 'can log in with github oauth' do
      stub_omni_auth
      visit root_path

      expect(page).to have_content('Welcome to MinimalHub!')
      expect(page).to have_link('Log In with GitHub')

      click_link 'Log In with GitHub'

      expect(page).to have_content('Bobby')
    end
  end
end
