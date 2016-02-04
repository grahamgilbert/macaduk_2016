class macaduk_demo::outset {
    package { 'outset':
        ensure   => installed,
        provider => pkgdmg,
        source   => 'http://192.168.33.10/outset-1.0.1.pkg',
    }
}
