require 'rails_helper'

RSpec.describe User, type: :model do
  subject { user }

  let(:user) { build(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password_digest) }

  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value('email@email.com').for(:email) }
  it { is_expected.not_to allow_value('invalid_email@').for(:email) }
  it { is_expected.to be_valid }
end
