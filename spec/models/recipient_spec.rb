require 'rails_helper'

RSpec.describe Recipient, type: :model do
  subject { recipient }

  let(:recipient) { build(:recipient) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:street) }
  it { is_expected.to validate_presence_of(:state) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:zip_code) }

  it { is_expected.to be_valid }
end
