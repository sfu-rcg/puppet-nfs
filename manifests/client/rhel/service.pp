# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::rhel::service {

  Service {
    require => Class['::nfs::client::rhel::configure']
  }

  if $nfs::client::rhel::nfs_v4_kerberized == true {
    $nfs4_kerberized_services_ensure = 'running'
  } else {
    $nfs4_kerberized_services_ensure = 'stopped'
  }


  if !defined(Service["$nfs::client::rhel::service_nfs"]) {
    service { "$nfs::client::rhel::service_nfs":
      ensure      => running,
      enable      => true,
      hasstatus   => true,
      hasrestart  => true,
      restart     => $nfs::client::rhel::service_nfs_restart_cmd,
      require     => Package["nfs-utils"],
    }    
  }


  if $nfs::client::rhel::osmajor >= 7 {
    service { [ "$nfs::client::rhel::service_nfslock", "$nfs::client::rhel::service_rpcidmapd", 'rpcbind' ]:
      ensure    => running,
      enable    => true,
      hasstatus => true,
      require   => [ Package["rpcbind"], Package["nfs-utils"] ],
    }
  }
  elsif $nfs::client::rhel::osmajor <= 6 {
    service { [ "$nfs::client::rhel::service_rpcgssd", "$nfs::client::rhel::service_rpcsvcgssd" ]:
      ensure      => $nfs4_kerberized_services_ensure,
      enable      => $nfs::client::rhel::nfs_v4_kerberized,
      hasstatus   => true,
    }
    if $nfs::client::rhel::osmajor == 6 {
      service { [ "$nfs::client::rhel::service_nfslock", "$nfs::client::rhel::service_rpcidmapd" ]:
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => Service["rpcbind"], 
      }
      service { "netfs":
        enable    => true,
        require   => Service["$nfs::client::rhel::service_nfslock"],
      }
      service { "rpcbind":
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [ Package["rpcbind"], Package["nfs-utils"] ],
      }
    } elsif $nfs::client::rhel::osmajor == 5 {
      service { $nfs::client::rhel::service_nfslock:
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [ Package["portmap"], Package["nfs-utils"] ],
      }
      service { "netfs":
        enable    => true,
        require   => [ Service["portmap"], Service[$nfs::client::rhel::service_nfslock] ],
      }
      service { "portmap":
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [ Package["portmap"], Package["nfs-utils"] ],
      }
    }
  }
}
