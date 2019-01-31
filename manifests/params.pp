class nfs::params (
  $nfs_v2_enable              = 'no',      # v2: not a typo
  $nfs_v4_export_root         = '/export',
  $nfs_v4_export_root_clients = "*.${::domain}(ro,fsid=root,insecure,no_subtree_check,async,root_squash)",
  $nfs_v4_mount_root          = '/srv',
  $nfs_v4_idmap_domain        = $::domain,
  $nfs_v4_kerberos_realm      = undef,
  $rpcgssd_opts               = undef,
  $rpcsvcgssd_opts            = undef,
  $rpcidmapd_opts             = undef,
  $rpcmountd_opts             = undef,
) {

  # Somehow the ::osfamily fact doesnt exist on some old systems

  case $::operatingsystem {
    'centos', 'rhel', 'scientific'           : { $osfamily = 'rhel' }
    'fedora'                                 : { $osfamily = 'fedora' }
    'redhat', 'SLC', 'OracleLinux', 'Amazon' : { $osfamily = 'rhel' }
    'debian', 'Ubuntu'                       : { $osfamily = 'debian' }
    'windows'                                : { fail('fail!11') }
    'darwin'                                 : { $osfamily = 'darwin' }
    'gentoo'                                 : { $osfamily = 'gentoo' }
    default                                  : { fail("OS: ${::operatingsystem} not supported") }
  }
}
