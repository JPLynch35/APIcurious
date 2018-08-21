require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can see their profile pic, name, number of starred repos, followers and followings' do
      user = User.create(
                          provider: 'github',
                          uid: ENV['JP_UID'],
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: ENV['JP_TEST_TOKEN']
                        )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      expect(page).to have_content(user.name)
      expect(page).to have_content("Number of Starred Repo: 0")
      expect(page).to have_content("Number Followers: 1")
      expect(page).to have_content("Number Following: 0")
    end
  end
end
