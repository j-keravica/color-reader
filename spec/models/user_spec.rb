require "rails_helper"

describe User do

  it { should have_db_column(:username) }
  it { should have_db_column(:email) }
  it { should have_db_column(:encrypted_password) }
  it { should have_db_column(:reset_password_token) }
  it { should have_db_column(:reset_password_sent_at) }
  it { should have_db_column(:remember_created_at) }
  it { should have_db_column(:sign_in_count) }
  it { should have_db_column(:current_sign_in_at) }
  it { should have_db_column(:last_sign_in_at) }
  it { should have_db_column(:current_sign_in_ip) }
  it { should have_db_column(:last_sign_in_ip) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should have_db_index(:username) }
  it { should have_db_index(:email) }
  it { should have_db_index(:reset_password_token) }

  describe "checks uniqueness" do

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:reset_password_token) }

    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }

  end

end
