# == Class: munki
#
# Installs Munki and installs a configuration profile with Munki settings
#
# === Parameters
#
# [*repourl*]
#   The URL of your Munki repo. Defaults to http://munki
#
# [*clientidentifier*]
#   The Mac's clientidentifier. Defaults to the Mac's serial number
#
# [*suppressautoinstall*]
#   Suppress auto installation of packages. Defaults to false
#
# [*suppress_stop*]
#   Suppress the stop button during installation. Defaults to true
#
# [*install_apple_updates*]
#   Allows Munki to install Apple Software Updates Defaults to false
#
# [*bootstrap*]
#   Touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup when the Munki package is changed. Defaults to false
#
# === Examples
#
#  class { 'munki':
#    repourl                     => "http://munki.example.com",
#    suppressstopbuttononinstall => true,
#    bootstrap                   => true,
#    clientidentifier            => 'demo_client',
#  }
#

class munki(
    $repourl = 'http://munki',
    $clientidentifier = '',
    $suppressautoinstall = false,
    $install_apple_updates = false,
    $suppress_stop = false,
    $bootstrap = false,
    $packageurl = '',
    $catalogurl = '',
    $manifesturl = '',
    $additionalhttpheaders = '',
    $manage_services = true,
    $install_tools = true,
    $install_conditions = true,
    $install_version = '2.4.0.2561',
    $toolsurl = 'https://github.com/munki/munki/releases/download/v2.4.0/munkitools-2.4.0.2561.pkg',
    ) {

    if $munki::install_tools == true {
        include munki::munkitools
    }

    if $munki::install_conditions == true {
        include munki::conditions
    }

    ##Install the profile
    mac_profiles_handler::manage { 'com.grahamgilbert.munkiprefs':
        ensure      => present,
        file_source => template('munki/com.grahamgilbert.munkiprefs.erb'),
        type        => 'template'
    }

    if $::mac_munki_version != "Munki not installed" {
        if $mac_admin::munki::manage_services == true {
            service { 'com.googlecode.munki.logouthelper':
                ensure => 'running',
                enable => 'true',
            }

            service { 'com.googlecode.munki.managedsoftwareupdate-check':
                ensure => 'running',
                enable => 'true',
            }

            service { 'com.googlecode.munki.managedsoftwareupdate-install':
                ensure => 'running',
                enable => 'true',
            }

            service { 'com.googlecode.munki.managedsoftwareupdate-manualcheck':
                ensure => 'running',
                enable => 'true',
            }
        }
    }
}
