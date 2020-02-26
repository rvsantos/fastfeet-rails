require 'rails_helper'

RSpec.describe Deliveryman, type: :model do
  subject { deliveryman }

  let(:deliveryman) { build(:deliveryman) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to be_valid }
end
