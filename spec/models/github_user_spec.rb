require 'rails_helper'

describe GithubUser, type: :model do
  it 'exists' do
    data = {name: 'Dave'}
    user = GithubUser.new(data)

    expect(user).to be_a(GithubUser)
  end
  it 'has a name attribute' do
    data = {login: 'Dave'}
    user = GithubUser.new(data)

    expect(user.name).to eq('Dave')
  end
end
