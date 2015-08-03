require "rails_helper"

RSpec.describe Page do

  it { is_expected.to have_db_column(:url) }
  it { is_expected.to have_db_column(:title) }
  it { is_expected.to have_db_column(:text) }

  it { is_expected.to have_db_index(:user_id) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_presence_of(:text) }

end
