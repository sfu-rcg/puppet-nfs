class nfs::client::debian::service {
  Service {
    require => Class['nfs::client::debian::configure']
  }

  if $nfs::client::debian::nfs_v4_kerberized == true {
    $nfs4_kerberized_services_ensure = 'running'
  } else {
    $nfs4_kerberized_services_ensure = 'stopped'
  }

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
  }


  case $::operatingsystemrelease {
    /^15\.\d+$/: {
      # 15.04 doesn't use idmapd for client side anymore.  Neither does Fedora 22.  It's all done differently without a service
    }
    default: {
      if $nfs::client::debian::nfs_v4 {
        service { "$nfs::client::debian::params::service_rpcidmapd":
          ensure    => running,
          subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
        }
      } else {
        service { "$nfs::client::debian::params::service_rpcidmapd": ensure => stopped, }
      }
    }
  }
}
