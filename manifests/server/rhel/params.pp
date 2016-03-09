class nfs::server::rhel::params {
  case $::operatingsystemrelease {
    /^[56]\.\d+/: {
      $osmajor = 6
      $nfslock = {
        name   => 'nfslock',
        enable => true
      }
      $nfs = {
        name        => 'nfs',
        enable      => true,
        has_restart => undef
      }
      $rpcsvcgssd = {
        name   => 'rpcsvcgssd',
        enable => true
      }
    }
    /^7\.\d+/: {
      $osmajor = 7
      $nfslock = {
        name   => 'nfs-lock',
        enable => undef
      }
      $nfs = {
        name        => 'nfs-server',
        enable      => true,
        has_restart => true,
      }
      $nfs_config = {
        name   => 'nfs-config',
        enable => undef
      }
      $rpcsvcgssd = {
        name   => 'rpc-svcgssd',
        enable => undef
      }
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }
}


