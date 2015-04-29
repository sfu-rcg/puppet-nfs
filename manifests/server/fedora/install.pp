class nfs::server::fedora::install {
  package { 'nfs4-acl-tools':
    ensure => installed,
  }
}
