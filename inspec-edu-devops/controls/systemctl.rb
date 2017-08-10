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
        :version => '2.3',
        :command => 'ansible --version'
    },
    :python3 => {
        :version => '3.6.2',
        :command => 'python3 --version'
    },
    :inspec => {
        :version => '1.32',
        :command => 'inspec --version'
    },
    :php => {
        :version => '7.0.19',
        :command => 'php --version' },
    :mysql => {
        :version => '5.5',
        :command => '/usr/sbin/mysqld --version',
        :port => '3306',
        :process => 'mysqld'
    },
    :nginx => {
        #:version => 'nginx\/1.10.3',
        #:command => '/usr/sbin/nginx -v',
        :port => '80',
        :process => 'nginx'
    },
    :jupyter => {
        :version => '4.3',
        :command => 'jupyter --version',
        :port => '8888',
        :process => 'python3.6'
    },
    :nodered => {
        :version => '0.17',
        :command => 'node-red --help',
        :port => '1880',
        :process => 'node-red'
    },
    :nodejs => {
        :version => '6.11',
        :command => 'nodejs -v'
    },
    :npm => {
        :version => '3.10',
        :command => 'npm -v'
    },
    :cloud9 => {
        :port => '8181',
        :process => 'node'
    },
    :ssh => {
        :port => '22',
        :process => 'sshd'
    },
    :pillow => {
        :version => '4.2',
        :command => 'pip3 show pillow'
    },
    :rpigpio => {
        :version => '0.6',
        :command => 'pip3 show rpi.gpio'
    },
    :sensehat => {
        :version => '2.2',
        :command => 'pip3 show sense-hat'
    },
    :blinkt => {
        :version => '0.1',
        :command => 'pip3 show blinkt'
    },
    :requests => {
        :version => '2.18',
        :command => 'pip3 show requests'
    },
    :psutil => {
        :version => '5.2',
        :command => 'pip3 show psutil'
    },
    :pahomqtt => {
        :version => '1.3',
        :command => 'pip3 show paho-mqtt'
    },
    :tweepy => {
        :version => '3.5',
        :command => 'pip3 show tweepy'
    },
    :noderedrpigpio => {
        :version => '0.17',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red/rpi-gpio'
    },
    :bigtimer => {
        :version => '1.7',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-contrib-bigtimer'
    },
    :dashboard => {
        :version => '2.4',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-dashboard'
    },
    :looptimer => {
        :version => '0.0.8',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-contrib-looptimer'
    },
    :noderedsensehat => {
        :version => '0.0.15',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-node-pi-sense-hat'
    },
    :noderedblinkt => {
        :version => '0.17',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red/rpi-blinkt'
    },
    :noderedexplorehat => {
        :version => '0.17',
        :commend => 'disabled',
        :command => 'node-red-admin info node-red/rpi-explorerhat'
    },
    :noderedflotilla => {
        :version => '0.17',
        :commend => 'Error',
        :command => 'node-red-admin info node-red/node-flotilla'
    },
    :noderedledborg => {
        :version => '0.17',
        :commend => 'disabled',
        :command => 'node-red-admin info node-red-node-ledborg/ledborg'
    },
    :noderedunicorn => {
        :version => '0.17',
        :commend => 'disabled',
        :command => 'node-red-admin info node-red/rpi-unicorn'
    },
    :mongodb => {
        :version => '2.4',
        :command => 'mongod --version'
    }
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
              if value[:commend]
                  its(:stdout) { should match /#{value[:commend]}/ }
              end
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
