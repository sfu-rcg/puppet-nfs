class nfs::client::debian::configure {
  Augeas{
    require => Class['nfs::client::debian::install']
  }

  if $nfs::client::debian::nfs_v4_kerberized == true {
    if $nfs::client::debian::rpcgssd_opts {
      $nfs_common_changes = [ 'set NEED_IDMAPD yes', 'set NEED_GSSD yes', "set RPCGSSDOPTS ${nfs::client::debian::rpcgssd_opts}" ] 
    }
    else {
      $nfs_common_changes = [ 'set NEED_IDMAPD yes', 'set NEED_GSSD yes' ] 
    }
  }
  else {
    $nfs_common_changes = [ 'set NEED_IDMAPD yes' ] 
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
          changes => ["set Domain ${nfs::client::debian::nfs_v4_idmap_domain}"],
      }
  }
}
