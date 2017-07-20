# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

# you add controls here
control 'systemctl-1.0' do                        # A unique ID for this control
  impact 1.0                                # The criticality, if this control fails.
  title 'Deamon are running'                # A human-readable title
  desc 'An optional description...'
  describe file('/tmp') do                  # The actual test
    it { should be_directory }
  end
end
