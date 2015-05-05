# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::rhel::params {
  case $::operatingsystemrelease {
    /^5\.\d+/: {
      $osmajor = 6
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
      $service_rpcgssd = 'rpcgssd'
      $service_rpcsvcgssd = 'rpcsvcgssd'
      $service_rpcidmapd = 'rpcidmapd'
      $service_nfs_restart_cmd = undef
    }
    /^6\.\d+$/: {
      $osmajor = 6
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
      $service_rpcgssd = 'rpcgssd'
      $service_rpcsvcgssd = 'rpcsvcgssd'
      $service_rpcidmapd = 'rpcidmapd'
      $service_nfs_restart_cmd = undef
    }
    /^7\.\d+/: {
      $osmajor = 7
      $service_nfslock = 'nfs-server'
      $service_nfs = 'nfs-server'
      $service_rpcgssd = 'rpc-server'
      $service_rpcsvcgssd = 'rpc-server'
      $service_rpcidmapd = 'nfs-server'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    # TODO: workaround for Fedora
    /^\d{2,}/: {
      $osmajor = 7
      $service_nfslock = 'nfs-server'
      $service_nfs = 'nfs-server'
      $service_rpcgssd = 'rpc-server'
      $service_rpcsvcgssd = 'rpc-server'
      $service_rpcidmapd = 'nfs-server'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}


