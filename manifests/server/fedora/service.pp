class nfs::server::fedora::service {
  if !defined(Service['nfs-server']) {
    service { 'nfs-server':
      provider   => 'systemd',
      name       => 'nfs-server',
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package["nfs-utils"],
      subscribe  => [ Concat['/etc/exports'], File['/etc/idmapd.conf'], File['/etc/sysconfig/nfs'] ],
    }
  }
}
