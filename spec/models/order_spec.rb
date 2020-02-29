require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { order }

  let(:order) { build(:order) }

  it { is_expected.to respond_to(:deliveryman) }
  it { is_expected.to respond_to(:recipient) }
  it { is_expected.to respond_to(:product) }
  it { is_expected.to respond_to(:start_date) }
  it { is_expected.to respond_to(:end_date) }
  it { is_expected.to respond_to(:canceled_at) }

  it { is_expected.to validate_presence_of(:product) }

  it { is_expected.to belong_to(:deliveryman) }
  it { is_expected.to belong_to(:recipient) }

  it { is_expected.to be_valid }
end
