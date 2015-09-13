class nfs::server::rhel::params {
  case $::operatingsystemrelease {
    /^[56]\.\d+/: {
      $osmajor = 6
      $nfslock = {
        name => 'nfslock',
        enable => true
      }
      $nfs = {
        name => 'nfs',
        enable => true,
        has_restart => undef
      }
      $rpcsvcgssd = {
        name => 'rpcsvcgssd',
        enable => true
      }
    }
    /^7\.\d+/: {
      $osmajor = 7
      $nfslock = {
        name => 'nfs-lock',
        enable => undef
      }
      $nfs = {
        name => 'nfs-server',
        enable => true,
        restart_cmd => '/usr/bin/systemctl reload nfs-server'
      }
      $rpcsvcgssd = {
        name => 'rpc-svcgssd',
        enable => undef
      }
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}


