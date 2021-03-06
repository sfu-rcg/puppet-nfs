class nfs::server::rhel(
  $nfs_v4                = false,
  $nfs_v4_idmap_domain   = undef,
  $nfs_v4_kerberized     = false,
  $nfs_v4_kerberos_realm = undef,
  $rpcgssd_opts          = undef,
  $rpcsvcgssd_opts       = undef,
  $rpcidmapd_opts        = undef,
  $rpcmountd_opts        = undef,
) inherits nfs::server::rhel::params {

  if !defined(Class['nfs::client::rhel']) {
    class{ 'nfs::client::rhel':
      nfs_v4                 => $nfs_v4,
      nfs_v4_idmap_domain    => $nfs_v4_idmap_domain,
      nfs_v4_kerberized      => $nfs_v4_kerberized,
      nfs_v4_kerberos_realm  => $nfs_v4_kerberos_realm,
      rpcgssd_opts           => $rpcgssd_opts,
      rpcsvcgssd_opts        => $rpcsvcgssd_opts,
      rpcidmapd_opts         => $rpcidmapd_opts,    
      rpcmountd_opts         => $rpcmountd_opts,
    }
  }

  include nfs::server::rhel::install,
          nfs::server::rhel::service
}

