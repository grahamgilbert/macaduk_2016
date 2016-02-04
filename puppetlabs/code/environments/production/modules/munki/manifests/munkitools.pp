class munki::munkitools {

    if $::mac_munki_version < $munki::install_version or $::mac_munki_version == "Munki not installed" {
        package { 'munki_tools':
            ensure   => installed,
            provider => pkgdmg,
            source   => $munki::toolsurl,
        }

        exec {'/bin/launchctl load /Library/LaunchDaemons/com.googlecode.munki.logouthelper.plist':
            refreshonly => true,
            subscribe   => Package['munki_tools']
        }

        exec {'/bin/launchctl load /Library/LaunchDaemons/com.googlecode.munki.managedsoftwareupdate-check.plist':
            refreshonly => true,
            subscribe   => Package['munki_tools']
        }

        exec {'/bin/launchctl load /Library/LaunchDaemons/com.googlecode.munki.managedsoftwareupdate-install.plist':
            refreshonly => true,
            subscribe   => Package['munki_tools']
        }

        exec {'/bin/launchctl load /Library/LaunchDaemons/com.googlecode.munki.managedsoftwareupdate-manualcheck.plist':
            refreshonly => true,
            subscribe   => Package['munki_tools']
        }

        ##If we need to, touch the bootstrap file
        if $mac_admin::munki::bootstrap==true {
            exec {'munki-check':
                command     => '/usr/bin/touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup',
                refreshonly => true,
                subscribe   => Package['munki_tools2'],
            }
        }
    }
}
