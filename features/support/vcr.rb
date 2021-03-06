require "vcr"

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir     = 'features/cassettes'
  c.default_cassette_options = { :record => :new_episodes }
  c.ignore_localhost = true
end

VCR.cucumber_tags do |t|
  t.tag "@valid_url"
  t.tag "@invalid_url"
end

