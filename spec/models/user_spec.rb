require "rails_helper"

RSpec.describe User do

  it { is_expected.to have_db_column(:username) }
  it { is_expected.to have_db_column(:email) }
  it { is_expected.to have_db_column(:encrypted_password) }
  it { is_expected.to have_db_column(:reset_password_token) }
  it { is_expected.to have_db_column(:reset_password_sent_at) }
  it { is_expected.to have_db_column(:remember_created_at) }
  it { is_expected.to have_db_column(:sign_in_count) }
  it { is_expected.to have_db_column(:current_sign_in_at) }
  it { is_expected.to have_db_column(:last_sign_in_at) }
  it { is_expected.to have_db_column(:current_sign_in_ip) }
  it { is_expected.to have_db_column(:last_sign_in_ip) }
  it { is_expected.to have_db_column(:created_at) }
  it { is_expected.to have_db_column(:updated_at) }

  it { is_expected.to have_db_index(:username) }
  it { is_expected.to have_db_index(:email) }
  it { is_expected.to have_db_index(:reset_password_token) }

  describe "validations" do

    it { is_expected.to validate_uniqueness_of(:username) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }

  end

end
