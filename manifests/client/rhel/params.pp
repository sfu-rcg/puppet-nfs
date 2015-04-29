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
    }
    /^6\.\d+$/: {
      $osmajor = 6
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
      $service_rpcgssd = 'rpcgssd'
      $service_rpcsvcgssd = 'rpcsvcgssd'
      $service_rpcidmapd = 'rpcidmapd'
    }
    /^7\.\d+/: {
      $osmajor = 7
      $service_nfslock = 'nfs-lock'
      $service_nfs = 'nfs-server'
      $service_rpcgssd = 'rpc-gssd'
      $service_rpcsvcgssd = 'rpc-svcgssd'
      $service_rpcidmapd = 'nfs-idmap'
    }
    # TODO: workaround for Fedora
    /^\d{2,}/: {
      $osmajor = 7
      $service_nfslock = 'nfs-lock'
      $service_nfs = 'nfs-server'
      $service_rpcgssd = 'rpc-gssd'
      $service_rpcsvcgssd = 'rpc-svcgssd'
      $service_rpcidmapd = 'nfs-idmap'
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}


