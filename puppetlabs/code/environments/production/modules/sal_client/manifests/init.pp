class sal_client (
    $key,
    $server = 'http://sal',
){
    case $::kernel {
        'Darwin':{
            mac_admin::osx_defaults { 'sal_server':
                ensure => present,
                domain => '/Library/Preferences/com.github.salopensource.sal',
                key    => 'ServerURL',
                value  => $server,
            }

            mac_admin::osx_defaults { 'sal_key':
                ensure => present,
                domain => '/Library/Preferences/com.github.salopensource.sal',
                key    => 'key',
                value  => $key,
            }

        }
    }

}
