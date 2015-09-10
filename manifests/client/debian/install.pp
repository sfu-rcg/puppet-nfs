class nfs::client::debian::install {

  package { 'rpcbind':
    ensure => installed,
  }

  Package['rpcbind'] -> Service['rpcbind']

  package { ['nfs-common', 'nfs4-acl-tools']:
    ensure => installed,
  }

  if $nfs::client::debian::nfs_v4_kerberized == true {
    if !defined(Package['krb5-user']) {
      package { 'krb5-user':
        ensure => present,
      }
    }
    if !defined(Package['krb5-config']) {
      package { 'krb5-config':
        ensure => present,
      }
    }
  }

}
