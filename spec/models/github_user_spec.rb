require 'rails_helper'

describe GithubUser, type: :model do
  it 'exists' do
    data = {name: 'Dave'}
    user = GitHubUser.new(data)

    expect(user).to be_a(GitHubUser)
  end
  it 'has a name attribute' do
    data = {name: 'Dave'}
    user = GitHubUser.new(data)

    expect(user.name).to eq('Dave')
  end
end
