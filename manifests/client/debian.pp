class nfs::client::debian (
  $nfs_v4 = false,
  $nfs_v4_idmap_domain = undef,
  $nfs_v4_kerberized = false,
  $nfs_v4_kerberos_realm = undef,
  $rpcnfsdargs = undef,
  $rpcgssd_opts = undef,
  $rpcsvcgssd_opts = undef,
  $rpcidmapd_opts = undef,
  $rpcmountd_opts = undef
) inherits nfs::client::debian::params {

  include nfs::client::debian::install,
    nfs::client::debian::configure,
    nfs::client::debian::service

}
