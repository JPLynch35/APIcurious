require 'rails_helper'

describe Organization, type: :model do
  it 'exists' do
    data = {login: 'Best Group Ever'}
    org = Organization.new(data)

    expect(org).to be_a(Organization)
  end
  it 'has a title attribute' do
    data = {login: 'Best Group Ever'}
    org = Organization.new(data)

    expect(org.name).to eq('Best Group Ever')
  end
end
