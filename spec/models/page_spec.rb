require "rails_helper"

describe Page do

  it { should have_db_column(:url) }
  it { should have_db_column(:title) }
  it { should have_db_column(:text) }

  it { should have_db_index(:user_id) }
  it { should belong_to(:user) }
  
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:text) }

end