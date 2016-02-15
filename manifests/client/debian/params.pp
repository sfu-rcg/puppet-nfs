class nfs::client::debian::params {
  case $::operatingsystemrelease {
    /^14\.\d+$/: {
      $osmajor = 14
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
      $service_rpcgssd = 'rpcgssd'
      $service_rpcsvcgssd = 'rpcsvcgssd'
      $service_rpcidmapd = 'idmapd'
      $service_nfs_restart_cmd = undef
    }
    /^15\.\d+/: {
      $osmajor = 15
      $service_nfslock = 'nfs-server'
      $service_nfs = 'nfs-client'
      $service_rpcgssd = 'rpc-gssd'
      $service_rpcsvcgssd = 'rpc-svcgssd'
      $service_rpcidmapd = 'nfs-idmapd'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    /^16\.\d+$/: {
      $osmajor = 16
      $service_nfslock = 'nfs-server'
      $service_nfs = 'nfs-client'
      $service_rpcgssd = 'rpc-gssd'
      $service_rpcsvcgssd = 'rpc-svcgssd'
      $service_rpcidmapd = 'nfs-idmapd'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}
