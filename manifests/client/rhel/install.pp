# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::rhel::install {

  Package {
    before => Class['::nfs::client::rhel::configure']
  }
  package { 'nfs-utils':
    ensure => present,
  }

  if $nfs::client::rhel::osmajor >= 6 {
    package {'rpcbind':
      ensure => present,
    }
  }
  elsif $nfs::client::rhel::osmajor == 5 {
    package { 'portmap':
      ensure => present,
    }
  }

  if $nfs::client::rhel::nfs_v4_kerberized {
    if !defined(Package['krb5-libs']) {
      package { 'krb5-libs':
        ensure => present,
      }
    }
    if !defined(Package['krb5-workstation']) {
      package { 'krb5-workstation':
        ensure => present,
      }
    }
    if !defined(Package['krb5-devel']) {
      package { 'krb5-devel':
        ensure => present,
      }
    }
  }
}

