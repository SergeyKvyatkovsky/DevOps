# # encoding: utf-8

# Inspec test for recipe admintools::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
describe port(5000), :skip do
  it { should_not be_listening }
end

describe package('Install Docker-ce') do
  it { should be_installed}
end

describe service('docker') do
  it { should be_enabled }
end