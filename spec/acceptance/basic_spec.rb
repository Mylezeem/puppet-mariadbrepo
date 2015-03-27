require 'spec_helper_acceptance'

describe 'mariadbrepo class' do

  context 'with default parameters' do
    case fact('osfamily')
      when 'RedHat'
        repofile = '/etc/yum.repos.d/MariaDB.repo'
      when 'Debian'
        repofile = '/etc/apt/sources.list.d/MariaDB.list'
    end

    it 'should work with no errors' do
      pp = 'include ::mariadbrepo'
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe yumrepo('MariaDB') do
      it { should be_enabled }
    end

    describe file(repofile) do
      its(:content) { should match /10.0/ }
    end
  end

  context 'with specific version' do
    case fact('osfamily')
      when 'RedHat'
        repofile = '/etc/yum.repos.d/MariaDB.repo'
      when 'Debian'
        repofile = '/etc/apt/sources.list.d/MariaDB.list'
    end
    it 'should work with no errors' do
      pp = 'class { \'::mariadbrepo\': version => \'5.5\' }'
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe yumrepo('MariaDB') do
      it { should be_enabled }
    end
    describe file(repofile) do
      its(:content) { should match /5.5/ }
    end
  end

end
