require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can click on a link to go the recent activity page for who they follow' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      expect(page).to have_link('Following: Recent Activity')

      click_link('Following: Recent Activity')

      expect(current_path).to eq(user_following_recent_activity_path(user))
    end
  end

  describe 'visiting the recent activity page for who they follow' do
    it 'can see a summary feed of the recent activity (commits) of who they follow' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_following_recent_activity_path(user)

      expect(page).to have_content('sfreeman422')
      expect(page).to have_content('MacInnes')
    end
    it 'can click the back button and return to the user show page' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_following_recent_activity_path(user)
      click_link 'Back'

      expect(current_path).to eq(user_path(user))
    end
  end
end
