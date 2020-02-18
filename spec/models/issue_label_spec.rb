require 'rails_helper'

RSpec.describe IssueLabel, type: :model do
  it 'can be instantiated' do
    expect(IssueLabel.new).to_not be_nil
  end
end
