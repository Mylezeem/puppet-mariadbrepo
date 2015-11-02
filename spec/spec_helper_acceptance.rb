#! /usr/bin/env ruby -S rspec
require 'beaker-rspec'

UNSUPPORTED_PLATFORMS = []

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  if hosts.first.is_pe?
    install_pe
    on hosts, 'mkdir -p /etc/puppetlabs/facter/facts.d'
  else
    install_puppet
    on hosts, 'mkdir -p /etc/facter/facts.d'
    on hosts, '/bin/touch /etc/puppet/hiera.yaml'
  end
  hosts.each do |host|
    on host, "mkdir -p #{host['distmoduledir']}"
  end
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'mariadbrepo')
    hosts.each do |host|
      # Needed for the consul module to download the binary per the modulefile
      on host, puppet('module', 'install', 'puppetlabs/stdlib', '--version', '4.9.0'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs/apt', '--version', '2.2.0'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
