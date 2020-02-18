require 'rails_helper'

RSpec.describe IssueSprint, type: :model do
  it 'can be instantiated' do
    expect(IssueSprint.new).to_not be_nil
  end
end
