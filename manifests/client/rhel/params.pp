# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::rhel::params {

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
      $rpcgssd = {
        name => 'rpcgssd',
        enable => true
      }
      $rpcsvcgssd = {
        name => 'rpcsvcgssd',
        enable => true
      }
      $rpcidmapd = {
        name => 'rpcidmapd',
        enable => true
      }
      $rpcbind = {
        name => 'rpcbind',
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
      $rpcgssd = {
        name => 'rpc-gssd',
        enable => undef
      }
      $rpcsvcgssd = {
        name => 'rpc-svcgssd',
        enable => undef
      }
      $rpcidmapd = {
        name => 'nfs-idmapd',
        enable => undef
      }
      $rpcbind = {
        name => 'rpcbind',
        enable => undef
      }
    }
    default:{
      fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
    }
  }

  #case $::operatingsystemrelease {
  #  /^[56]\.\d+/: {
  #    $osmajor = 6
  #    $service_nfslock = 'nfslock'
  #    $service_nfs = 'nfs'
  #    $service_rpcgssd = 'rpcgssd'
  #    $service_rpcsvcgssd = 'rpcsvcgssd'
  #    $service_rpcidmapd = 'rpcidmapd'
  #    $service_nfs_restart_cmd = undef
  #  }
  #  /^7\.\d+/: {
  #    $osmajor = 7
  #    $service_nfslock = 'nfs-lock'
  #    $service_nfs = 'nfs-server'
  #    $service_rpcgssd = 'rpc-gssd'
  #    $service_rpcsvcgssd = 'rpc-svcgssd'
  #    $service_rpcidmapd = 'nfs-idmapd'
  #    $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
  #  }
  #  # TODO: workaround for Fedora
  #  /^\d{2,}/: {
  #    $osmajor = 7
  #    $service_nfslock = 'nfs-lock'
  #    $service_nfs = 'nfs-server'
  #    $service_rpcgssd = 'rpc-gssd'
  #    $service_rpcsvcgssd = 'rpc-svcgssd'
  #    $service_rpcidmapd = 'nfs-idmapd'
  #    $service_nfs_restart_cmd = '/usr/bin/systemctl reload nfs-server'
  #  }
  #  default:{
  #    fail("Operatingsystemrelease ${::operatingsystemrelease} not supported")
  #  }
  #}
}


