# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::fedora::install {

  Package {
    before => Class['::nfs::client::fedora::configure']
  }
  package { 'nfs-utils':
    ensure => present,
  }
  package {'rpcbind':
      ensure => present,
  }

  if $nfs::client::rhel::nfs_v4_kerberized == true {
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

