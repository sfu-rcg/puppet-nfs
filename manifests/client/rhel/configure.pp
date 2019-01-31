# Shamefully stolen from https://github.com/frimik/puppet-nfs
# refactored a bit

class nfs::client::rhel::configure {

  # Because RHEL /etc/sysconfig/nfs doesn't want true/false;
  # it wants yes/no
  if $nfs::client::rhel::nfs_v4_kerberized == true {
     $nfs_v4_secure = 'yes'
  } else {
     $nfs_v4_secure = 'no'
  }

  # I know it's 2019 and this is insane, but we have some $$$$$ Agilent
  # equipment that will not be replaced anytime soon... never mind that
  # it was produced well after NFSv3 was ratified
  if $nfs::client::nfs_v2_enable == true {
     $nfs_v2_enable = 'yes'
  } else {
     $nfs_v2_enable = 'no'
  }

  $rpcnfsdargs = $nfs::client::rpcnfsdargs


  concat { '/etc/idmapd.conf':
    warn    => true,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
  concat { '/etc/sysconfig/nfs':
    warn    => true,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
  }
  concat::fragment { 'idmapd.conf.erb':
    target  => '/etc/idmapd.conf',
    order   => '01',
    content => template('nfs/idmapd.conf.erb'),
    notify  => Service[$nfs::client::rhel::rpcidmapd[name]],
  }
  concat::fragment { 'rhel-sysconfig-nfs':
    target  => '/etc/sysconfig/nfs',
    order   => '02',
    content => template('nfs/rhel-sysconfig-nfs.erb'),
    notify  => [ Service[$nfs::client::rhel::rpcgssd[name]], Service[$nfs::client::rhel::rpcidmapd[name]] ],
  }
}
