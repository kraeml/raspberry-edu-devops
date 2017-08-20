# encoding: utf-8
# copyright: 2015, The Authors
# license: All rights reserved

services = [
    "jupyter",
    "nodered",
    "nginx",
    "docker",
    "cloud9",
    "mysql",
    "etherpad-lite",
    "etherdraw",
    "dphys-swapfile",
    "mosquitto",
    "mongodb",
    "lxc.service"
]

files = {
    :phpinfo => {
        :path => '/var/www/html/index.php',
        :user => 'www-data',
        :group => 'www-data',
        :rights => '0644'
    }
}

users = {
    :pi => {
        :uname => 'pi',
        :gname => 'pi',
        :groups => [
            'adm',
            'dialout',
            'sudo',
            'www-data',
            'video',
            'users',
            'docker',
            'gpio'
        ],
        :notGroups => [
            'root'
        ],
        :home => '/home/pi'
    }
}

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
        :version => '1.33',
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
        :version => 'nginx\/1.10',
        :command => '/usr/sbin/nginx -v 2>&1',
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
        :commend => 'disabled',
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
    },
    :gpio => {
        :version => '2.44',
        :command => 'gpio -v'
    },
    :noderedmongo => {
        :version => '0.0.13',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-node-mongodb/mongo'
    },
    :noderedmysql => {
        :version => '0.0.16',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-node-mysql/mysql'
    },
    :lxc => {
        :version => '1.0',
        :command => 'lxc-create --version'
    },
    :abiword => {
        :version => '3.0',
        :command => '/usr/bin/abiword --version'
    },
    :libreoffice => {
        :version => '4.3',
        :command => '/usr/bin/libreoffice --version'
    }
}

control 'files' do
    impact 1.0
    title 'Ensure file/dirs exists'
    files.each do |key, value|
        describe file(value[:path]) do
          it { should exist }
        end
    end
end

control 'users-1.0' do
    impact 1.0
    title 'Ensure users are known'
    users.each do |key, value|
        describe user(value[:uname]) do
            it { should exist }
            its('group') { should eq "#{value[:gname]}" }
            # its('groups') { should eq value[:groups] }
            its('home') { should eq "#{value[:home]}" }
            #its('shell') { should eq '/bin/bash' }
            #its('mindays') { should eq 0 }
            #its('maxdays') { should eq 90 }
            #its('warndays') { should eq 8 }
        end
        describe command("id #{key.to_s}") do
            value[:groups].each do |group|
                its(:stdout) { should include group.to_s }
            end
            value[:notGroups ].each do |group|
                its(:stdout) { should_not include group.to_s }
            end
        end
    end
end

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
