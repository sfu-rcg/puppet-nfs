class nfs::client::debian::configure {
  Augeas{
    require => Class['nfs::client::debian::install']
  }

  if $nfs::client::debian::nfs_v4_kerberized == true {
    if $nfs::client::debian::rpcgssd_opts {
      $_rpcgssd_opts = $nfs::client::debian::rpcgssd_opts ? {
        ''      => '""',
        undef   => '""',
        default => $nfs::client::debian::rpcgssd_opts
      }
      $nfs_common_changes = [ 'set NEED_IDMAPD yes', 'set NEED_GSSD yes', "set RPCGSSDOPTS ${_rpcgssd_opts}" ]
    }
    else {
      $nfs_common_changes = [ 'set NEED_IDMAPD yes', 'set NEED_GSSD yes' ]
    }
    $nfs_idmapd_changes = [
      "set Domain ${nfs::client::debian::nfs_v4_idmap_domain}",
      "set Local-Realms ${nfs::client::debian::nfs_v4_kerberos_realm}"
    ]
  }
  else {
    $nfs_common_changes = [ 'set NEED_IDMAPD yes' ]
    $nfs_idmapd_changes = [ "set Domain ${nfs::client::debian::nfs_v4_idmap_domain}" ]
  }
  if $nfs::client::debian::nfs_v4 == true {
      augeas {
        '/etc/default/nfs-common':
          context => '/files/etc/default/nfs-common',
          changes => $nfs_common_changes,
          lens    => 'Shellvars.lns',
          incl    => '/etc/default/nfs-common';
        '/etc/idmapd.conf':
          context => '/files/etc/idmapd.conf/General',
          lens    => 'Puppet.lns',
          incl    => '/etc/idmapd.conf',
          changes => $nfs_idmapd_changes,
      }
  }
}
