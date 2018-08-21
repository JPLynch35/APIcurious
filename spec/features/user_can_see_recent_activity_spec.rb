require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can click on a link to go to their recent activity page' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      expect(page).to have_link('Recent Activity')

      click_link('Recent Activity')

      expect(current_path).to eq(user_recent_activity_path(user))
    end
  end

  # describe 'visiting the user recent activity page' do
  #   it 'can see a summary feed of their recent activity (commits)' do
  #     user = User.create(
  #                         provider: 'github',
  #                         uid: ENV['JP_UID'],
  #                         name: 'JP',
  #                         profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
  #                         token: ENV['JP_TEST_TOKEN']
  #                       )
  #     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

  #     visit user_path(user)

      
  #     expect(page).to have_content(user.name)
  #     expect(page).to have_content("Number of Starred Repo: 0")
  #     expect(page).to have_content("Number Followers: 1")
  #     expect(page).to have_content("Number Following: 0")
  #   end
  # end
end
