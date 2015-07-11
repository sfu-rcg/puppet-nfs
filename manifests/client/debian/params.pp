class nfs::client::debian::params {
  case $::operatingsystemrelease {
    /^14\.\d+$/: {
      $osmajor = 14
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
      $service_rpcgssd = 'rpcgssd'
      $service_rpcsvcgssd = 'rpcsvcgssd'
      $service_rpcidmapd = 'rpcidmapd'
      $service_nfs_restart_cmd = undef
    }
    /^7\.\d+/: {
      $osmajor = 15
      $service_nfslock = 'nfs-server'
      $service_nfs = 'nfs-server'
      $service_rpcgssd = 'nfs-server'
      $service_rpcsvcgssd = 'nfs-server'
      $service_rpcidmapd = 'nfs-server'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    # TODO: workaround for Fedora
    /^\d{2,}/: {
      $osmajor = 7
      $service_nfslock = 'nfs-server'
      $service_nfs = 'nfs-server'
      $service_rpcgssd = 'nfs-server'
      $service_rpcsvcgssd = 'nfs-server'
      $service_rpcidmapd = 'nfs-server'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}
