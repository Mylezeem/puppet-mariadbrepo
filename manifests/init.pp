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
) {

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

  yumrepo { 'MariaDB' :
    baseurl  => "http://yum.mariadb.org/${version}/${os}${os_ver}-${arch}",
    gpgkey   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
    gpgcheck => 1,
  }

}
