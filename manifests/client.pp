# == Class: nfs::client
#
# Set up NFS client and mounts. NFSv3 and NFSv4 supported.
#
#
# === Parameters
#
# [nfs_v4]
#   NFSv4 support.
#   Disabled by default.
#
# [nfs_v4_mount_root]
#   Mount root, where we  mount shares, default /srv
#
# [nfs_v4_idmap_domain]
#  Domain setting for idmapd, must be the same across server
#  and clients.
#
# [nfs_v4_kerberized]
#  (RHEL only) Toggles SECURE_NFS in /etc/sysconfig/nfs;
#  enables and runs rpc.gssd and rpc.svgssd
#
# [nfs_v4_kerberos_realm]
#  (RHEL only) For /etc/idmapd.conf's Local-Realms parameter.
#  Default is to use $::domain fact.
#
# [rpcgssd_opts]
#  (RHEL only) Passes options to rpc.gssd in /etc/sysconfig/nfs.
#
# [rpcsvcgssd_opts]
#  (RHEL only) Passes options to rpc.svcgssd in /etc/sysconfig/nfs.
#
# [rpcidmapd_opts]
#  (RHEL only) Passes options to rpc.idmapd in /etc/sysconfig/nfs.
#
# === Examples
#
#
#  class { 'nfs::client':
#    nfs_v4                 => true,
#    nfs_v4_kerberos_realm  => 'EXAMPLE.COM',
#    nfs_v4_kerberized      => true,
#    rpcgssd_opts	          => '-v',
#    rpcsvcgssd_opts        => '-v',
#    rpcidmapd_opts         => '-v',
#    # Generally parameters below have sane defaults.
#    nfs_v4_mount_root      => "/srv",
#    nfs_v4_idmap_domain    => $::domain,
#  }

class nfs::client (
  $nfs_v2_enable          = $::nfs::params::nfs_v2_enable,  # not a typo,
  $nfs_v4                 = false,
  $nfs_v4_mount_root      = $::nfs::params::nfs_v4_mount_root,
  $nfs_v4_idmap_domain    = $::nfs::params::nfs_v4_idmap_domain,
  $nfs_v4_kerberized      = false,
  $nfs_v4_kerberos_realm  = $::nfs::params::nfs_v4_kerberos_realm,
  $rpcgssd_opts           = $::nfs::params::rpcgssd_opts,
  $rpcsvcgssd_opts        = $::nfs::params::rpcsvcgssd_opts,
  $rpcidmapd_opts         = $::nfs::params::rpcidmapd_opts,
  $rpcmountd_opts         = $::nfs::params::rpcmountd_opts,
) inherits nfs::params {

  # ensure dependencies for mount

  Class["::nfs::client::${::nfs::params::osfamily}::install"] ->
  Class["::nfs::client::${::nfs::params::osfamily}::configure"] ->
  Class["::nfs::client::${::nfs::params::osfamily}::service"] ->
  Class['::nfs::client']

  if !defined( Class["::nfs::client::${::nfs::params::osfamily}"]) {
    class{ "nfs::client::${::nfs::params::osfamily}":
      nfs_v4                 => $nfs_v4,
      nfs_v4_idmap_domain    => $nfs_v4_idmap_domain,
      nfs_v4_kerberized      => $nfs_v4_kerberized,
      nfs_v4_kerberos_realm  => $nfs_v4_kerberos_realm,
      rpcgssd_opts           => $rpcgssd_opts,
      rpcsvcgssd_opts        => $rpcsvcgssd_opts,
      rpcidmapd_opts         => $rpcidmapd_opts,
      rpcmountd_opts         => $rpcmountd_opts,
    }
  }

}
