class nfs::server::rhel::install {
  package { 'nfs4-acl-tools':
    ensure => installed,
  }
}
