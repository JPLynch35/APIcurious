require 'rails_helper'

describe Repository, type: :model do
  it 'exists' do
    # data = {title: 'LittleTruck'}
    repo = Repository.new(data)

    expect(repo).to be_a(Repository)
  end
  it 'has a title attribute' do
    # data = {title: 'LittleTruck'}
    repo = Repository.new(data)

    expect(repo.title).to eq('LittleTruck')
  end
end
