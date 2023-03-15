require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(email: 'test@example.com', password: 'password123') }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('test@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe 'password encryption' do
    it 'encrypts the password' do
      expect(user.password_digest).not_to be_nil
    end
  end
end
