# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

services = [
    "jupyter",
    "nodered",
    "nginx",
    "docker",
    "cloud9",
    "mysql"
]
ansible = { :version => '2.2.1.0', :command => 'ansible --version'}
python3 = { :version => '3.6.2', :command => 'python3 --version'}
inspec = { :version => '1.31.1', :command => 'inspec --version'}
php = { :version => '7.0.19', :command => 'php --version'}

tools = [ ansible, python3, inspec, php ]

control 'ports-1.0' do
    impact 1.0
    title 'Ensure ports pare open'
    describe port(22) do        
      its('processes') { should include 'sshd' }
      its('protocols') { should include 'tcp' }
      its('addresses') { should include '0.0.0.0' }
    end
end

control 'packages-1.0' do
    impact 1.0
    title 'Ensure packages installed'
    tools.each do |tool|
        describe command(tool[:command]) do
          its(:stdout) { should match /#{tool[:version]}/ }
        end
    end
end
# you add controls here
control 'systemctl-1.0' do                        # A unique ID for this control
  impact 1.0                                # The criticality, if this control fails.
  title 'Services are running'                # A human-readable title
  desc 'An optional description...'
  for service in services do
      describe systemd_service(service) do
          it { should be_installed }
          it { should be_enabled }
          it { should be_running }
      end
  end
end
