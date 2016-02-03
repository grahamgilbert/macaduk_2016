class macaduk_demo::time_zone {
    if $mac_timezone != 'Europe/London' {
        exec {'/usr/sbin/systemsetup -settimezone Europe/London': }
    }
}
