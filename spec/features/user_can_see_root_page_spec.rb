require 'rails_helper'

describe 'a user' do
  describe 'visiting the root page' do
    it 'can see the standard greeting' do
      visit root_path

      expect(page).to have_content('Welcome to MinimalHub!')
      expect(page).to have_link('Log In with GitHub')
    end
  end
end
