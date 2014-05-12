require 'rubygems'
require 'puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'


desc 'Run syntax, lint and spec tests'
task :test => [:validate,:lint,:spec]

desc "Validate the Puppet syntax of all manifests"
task :validate do
  Dir['./manifests/**/*.pp'].each do |filename|
    sh "puppet parser validate '#{filename}'"
  end
end

desc 'Run puppet-lint on Puppet manifests defined in this repo'
task :lint do
  # Including puppet-lint rake tasks after the puppetlabs_spec_helper tasks to
  # make sure that the pl_s_h lint task doesn't overwrite our configuration below
  require 'puppet-lint/tasks/puppet-lint'

  PuppetLint.configuration.send('disable_80chars')
end
