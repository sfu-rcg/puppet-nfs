class nfs::server::rhel::params {
  case $::operatingsystemrelease {
    /^5\.\d+/: {
      $osmajor = 5
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
      $service_nfs_restart_cmd = undef
    }
    /^6\.\d+$/: {
      $osmajor = 6
      $service_nfslock = 'nfslock'
      $service_nfs = 'nfs'
      $service_nfs_restart_cmd = undef
    }
    /^7\.\d+/: {
      $osmajor = 7
      $service_nfslock = 'nfs-lock'
      $service_nfs = 'nfs-server'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    # TODO: workaround for Fedora
    /^\d{2,}/: {
      $osmajor = 7
      $service_nfslock = 'nfs-lock'
      $service_nfs = 'nfs-server'
      $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}


