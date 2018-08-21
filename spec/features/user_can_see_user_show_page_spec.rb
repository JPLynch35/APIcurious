require 'rails_helper'

describe 'a logged in user ' do
  describe 'visiting the user show page' do
    it 'can see their profile pic, name, number of starred repos, followers and followings' do
      user = User.create(
                          provider: 'github',
                          uid: '32902349',
                          name: 'JP',
                          profile_pic: 'https://avatars0.githubusercontent.com/u/32905782?...',
                          token: '0e23498239eb98238423eb'
                        )
      starred_repos_api_result = ['project1', 'project2', 'project3']
      followers_api_result = ['user1', 'user2', 'user3', 'user4']
      following_api_result = ['user1', 'user2']
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit user_path(user)

      expect(page).to have_content(user.name)
      expect(page).to have_content("Number of Starred Repo: #{starred_repos_api_result.count}")
      expect(page).to have_content("Number Followers: #{followers_api_result.count}")
      expect(page).to have_content("Number Following: #{following_api_result.count}")
    end
  end
end
