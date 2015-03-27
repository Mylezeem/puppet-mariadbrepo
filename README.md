#puppet-mariadbrepo

[![Build Status](https://api.travis-ci.org/Mylezeem/puppet-mariadbrepo.svg?branch=master)](https://travis-ci.org/Mylezeem/puppet-mariadbrepo)
[![Puppet Forge Version](http://img.shields.io/puppetforge/v/yguenane/mariadbrepo.svg)](https://forge.puppetlabs.com/yguenane/mariadbrepo)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/yguenane/mariadbrepo.svg)](https://forge.puppetlabs.com/yguenane/mariadbrepo)
[![License](http://img.shields.io/:license-apache-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0.html)

##Overview

A puppet module that configure the MariaDB repository on a Linux system.

##Module Description

Based on your system specifications, this module will install a the repository to install MariaDB.

##Usage

As it simplest, simply include the `mariadbrepo` class

```puppet
include mariadbrepo
```

If one wants a specific version of MariaDB simply specify it (default is 10.0)

```puppet
class {'mariadbrepo' :
  version => '5.5',
}
```
##Parameters

####`ensure`

Specify if the repository file should be present on the system. Possible values are `present` (default) or `absent`

####`mirror`

Specify the mirror to pull the packages from (ie. Debian based OS only)

####`version`

Version of MariaDB repo to install. Current Possible values are '5.5' or '10.0' (default)

##Limitations

This module works for :

* EL5/6/7
* Fedora 19/20/21
* Debian 6/7
* Ubuntu 10.04/12.04/14.04/14.10
