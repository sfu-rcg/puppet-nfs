class nfs::server::rhel::service {
  if $nfs::server::rhel::nfs_v4_kerberized == true {
    $nfs4_kerberized_services_ensure = 'running'
  } else {
    $nfs4_kerberized_services_ensure = 'stopped'
  }

  if $nfs::client::rhel::rpcsvcgssd[enable] == undef {
    $rpcsvcgssd_enable = undef
  }
  elsif $nfs::client::rhel::rpcsvcgssd[enable] == false {
    $rpcsvcgssd_enable = false
  }
  elsif $nfs4_kerberized == true {
    $rpcsvcgssd_enable = true
  }
  else {
    $rpcsvcgssd_enable = false
  }

  service { $nfs::server::rhel::rpcsvcgssd[name]:
    ensure    => $nfs4_kerberized_services_ensure,
    enable    => $rpcsvcgssd_enable,
    hasstatus => true,
    subscribe => Concat['/etc/sysconfig/nfs'],
  }
  service { $nfs::server::rhel::nfs_config[name]:
    ensure    => running,
    enable    => $nfs::server::rhel::nfs_config[enable],
    hasstatus => true,
    subscribe => Concat['/etc/sysconfig/nfs'],
    before    => Service[$nfs::server::rhel::nfs[name]]
  }
  if !defined(Service[$nfs::client::rhel::nfs[name]]) {
    service { $nfs::server::rhel::nfs[name]:
      ensure     => running,
      enable     => $nfs::server::rhel::nfs[enable],
      hasrestart => $nfs::server::rhel::nfs[has_restart],
      hasstatus  => true,
      require    => Package['nfs-utils'],
      subscribe  => [ Concat['/etc/exports'], Concat['/etc/idmapd.conf'], Concat['/etc/sysconfig/nfs'] ],
    }
  }
  else {
    service { $nfs::server::rhel::nfs[name]:
      ensure     => running,
      enable     => $nfs::server::rhel::nfs[enable],
      hasrestart => $nfs::server::rhel::nfs[has_restart],
      hasstatus  => true,
      require    => Package['nfs-utils'],
      subscribe  => [ Concat['/etc/exports'], Concat['/etc/idmapd.conf'], Concat['/etc/sysconfig/nfs'] ],
    }
  }
}
