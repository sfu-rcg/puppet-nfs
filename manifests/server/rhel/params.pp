class nfs::server::rhel::params {
  case $::operatingsystemrelease {
    /^5\.\d+/: {
      $osmajor = 5
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
    }
    /^6\.\d+$/: {
      $osmajor = 6
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
    }
    /^7\.\d+/: {
      $osmajor = 7
      $service_nfslock = 'nfs-lock'
      $service_nfs = 'nfs-server'
    }
    # TODO: workaround for Fedora
    /^\d{2,}/: {
      $osmajor = 7
      $service_nfslock = 'nfs-lock'
      $service_nfs = 'nfs-server'
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}


