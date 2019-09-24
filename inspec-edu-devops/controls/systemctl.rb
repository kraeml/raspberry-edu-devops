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
    "mongodb"
    #lxc.service"
]

gem_packages = {
    :bundler => {
        :version => "1.17.1"
    },
    :capybara => {
        :version => "3.10.0"
    },
    :inspec => {
        :version => "1.51.25"
    },
    :"selenium-webdriver" => {
        :version => "3.14.1"
    },
    :"cucumber" => {
        :version => "3.1.2"
    },
    :"rspec-expectations" => {
        :version => "3.8.2"
    },
    :"poltergeist" => {
        :version => "1.18.1"
    },
    :"launchy" => {
        :version => "2.4.3"
    },
    :"rest-client" => {
        :version => "2.0.2"
    }
}

files = {
    :phpinfo => {
        :path => '/var/www/html/index.php',
        :user => 'www-data',
        :group => 'www-data',
        :rights => '0644'
    },
    :ansible_hosts => {
        :path => '/etc/ansible/hosts',
        :user => 'root',
        :group => 'root',
        :rights => '0644'
    }
}

users = {
    :pi => {
        :uname => 'pi',
        :gname => 'pi',
        :groups => [
          'pi',
          'adm',
          'dialout',
          'sudo',
          'audio',
          'www-data',
          'video',
          'users',
          'input',
          'gpio',
	        'docker',
          'plugdev',
          'netdev'
        ],
        :notGroups => [
            'root'
        ],
        :home => '/home/pi'
    },
    :"www-data" => {
        :uname => 'www-data',
        :gname => 'www-data',
        :groups => [
	    'www-data',
        'gpio'],
        :notGroups => [
            'root'
        ],
        :home => '/var/www'
    }
}

tools = {
    :ansible => {
        :version => '2.7.1',
        :version_command => '',
        :command => 'ansible --version'
    },
    :python3 => {
        :version => '3.5.3',
        :version_command => '',
        :command => 'python3 --version'
    },
    :php => {
        :version => '7.0.30',
        :version_command => '',
        :command => 'php --version' },
    :mysql => {
        :version => '10.1',
        :version_command => '',
        :command => '/usr/sbin/mysqld --version |sed "s/  / /g" | cut -d \  -f 3',
        :port => '3306',
        :process => 'mysqld'
    },
    :nginx => {
        :version => '1.10',
        :version_command => '',
        :command => '/usr/sbin/nginx -v 2>&1 | cut -d / -f 2'#,
        #:port => '80',
        #:process => 'nginx'
    },
    :jupyter => {
        :version => '4.4',
        :version_command => '',
        :command => 'jupyter --version',
        :port => '8888',
        :process => 'jupyter-noteboo' # This is right without k
    },
    :pip3_jupyter => {
        :version => '1.0',
        :version_command => '',
        :command => 'pip3 show jupyter'
    },
    # Not included in hypriot
    #:pip3_readline => {
    #    :version => '6.2',
    #    :version_command => '',
    #    :command => 'pip3 show readline'
    #},
    # Not included in hypriot
    #:pip3_ipyparallel => {
    #    :version => '6.0',
    #    :version_command => '',
    #    :command => 'pip3 show ipyparallel'
    #},
    :pip3_bash_kernel => {
        :version => '0.7.1',
        :version_command => '',
        :command => 'pip3 show bash_kernel'
    },
    :jupyter_bash_kernel => {
        :commend => 'bash',
        :command => 'jupyter-kernelspec list'
    },
    :jupyter_python3 => {
        :commend => 'python3',
        :command => 'jupyter-kernelspec list'
    },
    # Not included in hypriot
    #:jupyter_javascript => {
    #    :version => 'javascript',
    #    :version_command => '',
    #    :command => 'jupyter-kernelspec list'
    #},
    :jupyter_widgets => {
        :commend => 'widgets.*enabled',
        :command => 'jupyter nbextension list'
    },
    # Not included in hypriot
    #:pip3_ipython_sql => {
    #    :version => '0.3',
    #    :version_command => '',
    #    :command => 'pip3 show ipython-sql'
    #},
    :nodered => {
        :version => '0.19',
        :version_command => '',
        :command => 'node-red --help',
        :port => '1880',
        :process => 'node-red'
    },
    :nodejs => {
        :version => '8.0',
        :version_command => '',
        :command => 'nodejs -v'
    },
    :npm => {
        :version => '6.0',
        :version_command => '',
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
        :version => '4.0',
        :version_command => '',
        :command => 'pip3 show pillow'
    },
    # On hypriot the stretch packages will installed
    #:rpigpio => {
    #    :version => '0.6',
    #    :version_command => '',
    #    :command => 'pip3 show rpi.gpio'
    #},
    :sensehat => {
        :version => '2.2',
        :version_command => '',
        :command => 'pip3 show sense-hat'
    },
    # On hypriot the stretch packages will installed
    #:blinkt => {
    #    :version => '0.1',
    #    :version_command => '',
    #    :command => 'pip3 show blinkt'
    #},
    :requests => {
        :version => '2.12',
        :version_command => '',
        :command => 'pip3 show requests'
    },
    :psutil => {
        :version => '5.4',
        :version_command => '',
        :command => 'pip3 show psutil'
    },

    :pahomqtt => {
        :version => '1.4',
        :version_command => '',
        :command => 'pip3 show paho-mqtt'
    },
    :tweepy => {
        :version => '3.5',
        :version_command => '',
        :command => 'pip3 show tweepy'
    },
    :noderedrpigpio => {
        :version => '0.19',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red/rpi-gpio'
    },
    :bigtimer => {
        :version => '2.0',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-contrib-bigtimer'
    },
    :dashboard => {
        :version => '2.10',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-dashboard'
    },
    :looptimer => {
        :version => '0.0.8',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-contrib-looptimer'
    },
    :noderedsensehat => {
        :version => '0.0.18',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-node-pi-sense-hat'
    },
    :noderedopcua => {
        :version => '0.2.32',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-contrib-opcua'
    },
    :noderedopcuaiiot => {
        :version => '3.3.0',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-contrib-iiot-opcua'
    },
    :noderedsolarpowerforecast => {
        :version => '1.0.3',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-contrib-solar-power-forecast'
    },
    :noderedopenweathermap => {
        :version => '0.2.1',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-node-openweathermap'
    },
    :noderedblinkt => {
        :version => '0.19',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red/rpi-blinkt'
    },
    :noderedexplorehat => {
        :version => '0.19',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'disabled',
        :command => 'node-red-admin info node-red/rpi-explorerhat'
    },
    :noderedflotilla => {
        :version => '0.19',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'disabled',
        :command => 'node-red-admin info node-red/node-flotilla'
    },
#    :noderedledborg => {
#        :version => '0.17',
#        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
#        :commend => 'disabled',
#        :command => 'node-red-admin info node-red-node-ledborg/ledborg'
#    },
    :noderedunicorn => {
        :version => '0.19',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'disabled',
        :command => 'node-red-admin info node-red/rpi-unicorn'
    },
    :mongodb => {
        :version => '2.4',
        :version_command => '',
        :command => 'mongod --version'
    },
    :gpio => {
        :version => '2.46',
        :version_command => '',
        :command => 'gpio -v'
    },
    :noderedmongo => {
        :version => '0.0.14',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-node-mongodb/mongo'
    },
    :noderedmysql => {
        :version => '0.0.17',
        :version_command => ' | grep -i version | cut -d : -f 2 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | tr -d \  ',
        :commend => 'enabled',
        :command => 'node-red-admin info node-red-node-mysql/mysql'
    },
    #:lxc => {
    #    :version => '1.0',
    #    :version_command => '',
    #    :command => 'lxc-create --version'
    #},
    :abiword => {
        :version => '3.0',
        :version_command => '',
        :command => '/usr/bin/abiword --version'
    },
    :libreoffice => {
        :version => '5.2',
        :version_command => '',
        :command => '/usr/bin/libreoffice --version'
    },
    :phantomjs => {
        :version => '2.1',
        :version_command => '',
        :command => 'phantomjs --version'
    },
    :pip3_selenium => {
        :version => '3.14.1',
        :version_command => '',
        :command => 'pip3 show selenium'
    },
    :geckodriver => {
        :version => '0.18.0',
        :version_command => '',
        :command => 'geckodriver --version'
    },
    :pyvirtualdisplay => {
        :version => '0.2',
        :version_command => '',
        :command => 'pip3 show pyvirtualdisplay'
    },
    :wiringpi => {
        :version => '2.46',
        :version_command => '',
        :command => 'gpio -v'
    },
    :gem => {
        :version => '2.5',
        :version_command => '',
        :command => 'gem -v'
    },
    :tidy => {
        :version => '5.2',
        :version_command => '',
        :command => 'tidy --version'
    },
    :java => {
        :commend => 'build 11',
        :command => 'java -version 2>&1'
    }
}

control 'gem packages' do
    impact 1.0
    title 'Ensure gem packages are installed'
    gem_packages.each do | key, value|
        describe gem(key) do
            it { should be_installed }
            its('version') { should cmp >= value[:version] }
        end
    end
end

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
            #its('groups') { should eq value[:groups] }
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
    title 'Ensure ports are open'
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
          if value[:version]
            describe command(value[:command] + value[:version_command]) do
              its(:stdout) { should cmp >= value[:version] }
            end
          end
          if value[:commend]
            describe command(value[:command]) do
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
