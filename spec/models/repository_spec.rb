require 'rails_helper'

describe Repository, type: :model do
  it 'exists' do
    data = {name: 'LittleTruck'}
    repo = Repository.new(data)

    expect(repo).to be_a(Repository)
  end
  it 'has a title attribute' do
    data = {name: 'LittleTruck'}
    repo = Repository.new(data)

    expect(repo.title).to eq('LittleTruck')
  end
end
