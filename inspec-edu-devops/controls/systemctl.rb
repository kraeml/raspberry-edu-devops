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
tools = {
    :ansible => {
        :version => '2.2.1.0',
        :command => 'ansible --version' },
    :python3 => {
        :version => '3.6.2',
        :command => 'python3 --version' },
    :inspec => {
        :version => '1.31.1',
        :command => 'inspec --version' },
    :php => {
        :version => '7.0.19',
        :command => 'php --version' },
    :mysql => {
        :version => '5.5.55',
        :command => '/usr/sbin/mysqld --version',
        :port => '3306',
        :process => 'mysqld' },
    :nginx => {
        #:version => 'nginx\/1.10.3',
        #:command => '/usr/sbin/nginx -v',
        :port => '80',
        :process => 'nginx' },
    :jupyter => {
        :version => '4.3.0',
        :command => 'jupyter --version',
        :port => '8888',
        :process => 'python3.6' },
    :nodered => {
        :version => '6.11.1',
        :command => 'node-red-pi --version',
        :port => '1880',
        :process => 'node-red' },
    :cloud9 => {
        :port => '8181',
        :process => 'node'},
    :ssh => {
        :port => '22',
        :process => 'sshd'}
}

control 'ports-1.0' do
    impact 1.0
    title 'Ensure ports pare open'
    tools.each do |key, value|
        if value[:port]
            describe port(value[:port]) do
              its('processes') { should include value[:process] }
              its('protocols') { should include 'tcp' }
              its('addresses') { should include '0.0.0.0' }
            end
        end
    end
end

control 'packages-1.0' do
    impact 1.0
    title 'Ensure packages installed'
    tools.each do |key, value|
        if value[:command]
            describe command(value[:command]) do
              its(:stdout) { should match /#{value[:version]}/ }
            end
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
