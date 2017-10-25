require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it { is_expected.to respond_to :account_number_from }
  it { is_expected.to respond_to :account_number_to }
  it { is_expected.to respond_to :amount_pennies }
  it { is_expected.to respond_to :country_code_from }
  it { is_expected.to respond_to :country_code_to }
  it { is_expected.to respond_to :user }
end
