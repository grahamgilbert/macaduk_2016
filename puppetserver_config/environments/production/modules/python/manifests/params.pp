# == Class: python::params
#
# The python Module default configuration settings.
#
class python::params {
  $ensure                 = 'present'
  $version                = 'system'
  $pip                    = 'present'
  $dev                    = 'absent'
  $virtualenv             = 'absent'
  $gunicorn               = 'absent'
  $manage_gunicorn        = true
  $provider               = undef
  $valid_versions = $::osfamily ? {
    'RedHat' => ['3'],
    'Debian' => ['3', '3.3', '2.7'],
    'Suse'   => [],
  }
  $use_epel               = true
}
