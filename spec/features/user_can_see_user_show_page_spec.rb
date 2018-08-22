require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can see their profile pic, name, number of starred repos, number of followers, number followings, list of organizations, and list of all repos' do
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
      expect(page).to have_content("Number Followers:")
      expect(page).to have_css(".follower", count: 1)
      expect(page).to have_content("Number Following:")
      expect(page).to have_css(".following", count: 0)
      expect(page).to have_content("Organizations:")
      expect(page).to have_css(".organization", count: 0)
      expect(page).to have_content("Repositories:")
      expect(page).to have_css(".repository", count: 38)
    end
  end
end
