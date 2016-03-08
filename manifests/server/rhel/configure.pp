# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::server::rhel::configure {

  concat::fragment { 'rhel-sysconfig-nfs_server':
    target  => '/etc/sysconfig/nfs',
    order   => '03',
    content => template('nfs/rhel-sysconfig-nfs_server.erb'),
    notify  => [ Service[$nfs::client::rhel::rpcgssd[name]], Service[$nfs::client::rhel::rpcidmapd[name]] ],
  }  
}
