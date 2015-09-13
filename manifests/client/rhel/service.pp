class nfs::client::rhel::service {

  Service {
    require => Class['::nfs::client::rhel::configure']
  }

  if $nfs::client::rhel::nfs_v4_kerberized == true {
    $nfs4_kerberized_services_ensure = 'running'
  } else {
    $nfs4_kerberized_services_ensure = 'stopped'
  }

  if $nfs::client::rhel::rpcgssd[enable] == undef {
    $rpcgssd_enable = undef
  }
  elsif $nfs::client::rhel::rpcgssd[enable] == false {
    $rpcgssd_enable = false
  }
  elsif $nfs4_kerberized == true {
    $rpcgssd_enable = true
  }
  else {
    $rpcgssd_enable = false
  }

  # I believe this should only be required on nfs servers
  #if !defined(Service[$nfs::client::rhel::nfs['name']]) {
  #  service { $nfs::client::rhel::nfs['name']:
  #    ensure      => running,
  #    enable      => $nfs::client::rhel::nfs['enable'],
  #    hasstatus   => true,
  #    hasrestart  => true,
  #    restart     => $nfs::client::rhel::nfs['restart_cmd'],
  #    require     => Package['nfs-utils'],
  #    subscribe   => Concat['/etc/sysconfig/nfs'],
  #  }    
  #}

  service { $nfs::client::rhel::rpcgssd[name]:
    ensure    => $nfs4_kerberized_services_ensure,
    enable    => $rpcgssd_enable,
    hasstatus => true,
  }

  if $nfs::client::rhel::osmajor >= 7 {
    service { $nfs::client::rhel::rpcidmapd[name]:
      ensure    => running,
      enable    => $nfs::client::rhel::rpcidmapd[enable],
      hasstatus => true,
      require   => [ Package['rpcbind'], Package['nfs-utils'] ],
    }
    service { $nfs::client::rhel::rpcbind[name]:
      ensure    => running,
      enable    => $nfs::client::rhel::rpcbind[enable],
      hasstatus => true,
      require   => [ Package['rpcbind'], Package['nfs-utils'] ],
    }
  }
  elsif $nfs::client::rhel::osmajor <= 6 {
    if $nfs::client::rhel::osmajor == 6 {
      service { $nfs::client::rhel::nfslock[name]:
        ensure    => running,
        enable    => $nfs::client::rhel::nfslock[enable],
        hasstatus => true,
        require   => Service[$nfs::client::rhel::rpcbind[name]], 
      }
      service { $nfs::client::rhel::rpcidmapd[name]:
        ensure    => running,
        enable    => $nfs::client::rhel::rpcidmapd[enable],
        hasstatus => true,
        require   => Service[$nfs::client::rhel::rpcbind[name]], 
      }
      service { 'netfs':
        enable    => true,
        require   => Service[$nfs::client::rhel::nfslock[name]],
      }
      service { $nfs::client::rhel::rpcbind[name]:
        ensure    => running,
        enable    => $nfs::client::rhel::rpcbind[enable],
        hasstatus => true,
        require   => [ Package['rpcbind'], Package['nfs-utils'] ],
      }
    } elsif $nfs::client::rhel::osmajor == 5 {
      service { $nfs::client::rhel::nfslock[name]:
        ensure    => running,
        enable    => $nfs::client::rhel::nfslock[enable],
        hasstatus => true,
        require   => [ Package['portmap'], Package['nfs-utils'] ],
      }
      service { 'netfs':
        enable    => true,
        require   => [ Service['portmap'], Service[$nfs::client::rhel::nfslock[name]] ],
      }
      service { 'portmap':
        ensure    => running,
        enable    => true,
        hasstatus => true,
        require   => [ Package['portmap'], Package['nfs-utils'] ],
      }
    }
  }
}
