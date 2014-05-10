# == Class: mariadbrepo
#
# A puppet module that configure the MariaDB repository on an Enterprise Linux (and relatives) system
#
# === Parameters
#
# [*version*]
#   (float) MariaDB version number
#   Possible value: 5.5, 10.0
#   Default: 10.0
#
# [*repo_desc_path*]
#   (string) Path to the repositories description files
#   Default: /etc/yum.repos.d/
#
# === Examples
#
#  include mariadbrepo
#
#    or
#
#  class { mariadbrepo:
#   version => '5.5',
#  }
#
# === Authors
#
# Yanis Guenane <yguenane@gmail.com>
#
# === Copyright
#
# Copyright 2014 Yanis Guenane
#
class mariadbrepo (
  $version        = '10.0',
  $repo_desc_path = '/etc/yum.repos.d',
){

  if ! ($::operatingsystem in ['RedHat', 'Fedora', 'CentOS']) {
    fail ("This module does not support your operating system : ${::operatingsystem}")
  }

  $os = $::operatingsystem ? {
    'RedHat' => 'rhel',
    'CentOS' => 'centos',
    'Fedora' => 'fedora',
  }

  $os_ver = $::operatingsystemrelease ? {
    /6.[0-9]/  => '6',
    /5.[0-9]+/ => '5',
    default    => $::operatingsystemrelease,
  }

  $arch = $::architecture ? {
    'i386'   => 'x86',
    'x86_64' => 'amd64',
  }

  file { "${repo_desc_path}/mariadb.repo" :
    ensure  => present,
    content => template('mariadbrepo/mariadb.repo'),
  }

}
