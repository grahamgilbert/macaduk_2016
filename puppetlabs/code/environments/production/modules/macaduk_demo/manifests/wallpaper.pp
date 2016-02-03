class macaduk_demo::wallpaper (
    $motivate = false,
    ){

    if !defined(File['/Library/Management']){
        file {'/Library/Management':
            ensure => directory,
        }
    }

    if !defined(File['/Library/Management/Wallpaper']){
        file {'/Library/Management/Wallpaper':
            ensure => directory,
        }
    }


    if $macaduk_demo::wallpaper::motivate == true {
        file {'/Library/Management/Wallpaper/motivate.jpg':
            ensure => present,
            source => 'puppet:///modules/macaduk_demo/wallpaper/motivate.jpg',
            mode   => '0644',
            owner  => '0',
            group  => '0',
        }

        $path = '/Library/Management/Wallpaper/motivate.jpg'

    } else {
        file {'/Library/Management/Wallpaper/corp_wallpaper.jpg':
            ensure => present,
            source => 'puppet:///modules/macaduk_demo/wallpaper/corp_wallpaper.jpg',
            mode   => '0644',
            owner  => '0',
            group  => '0',
        }

        $path = '/Library/Management/Wallpaper/corp_wallpaper.jpg'
    }

    # Template consumes $path variable
    
    mac_profiles_handler::manage { 'com.company.wallpaper':
        ensure      => 'present',
        type        => 'template',
        file_source => template('macaduk_demo/com.company.wallpaper.mobileconfig.erb'),
        require     => File["${path}"]
    }
}
