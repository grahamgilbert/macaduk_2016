class macaduk {
    file {'/sal_cert.py':
        ensure => 'present',
        source => 'puppet:///modules/macaduk/sal_cert.py',
        mode   => '0755',
    }

    if !defined(File['/usr']){
        file {'/usr':
            ensure => 'directory',
        }
    }

    if !defined(File['/usr/local']){
        file {'/usr/local':
            ensure => 'directory',
        }
    }

    if !defined(File['/usr/local/initial_db']){
        file {'/usr/local/initial_db':
            ensure => 'directory',
        }
    }

    if !defined(File['/usr/local/bin']){
        file {'/usr/local/bin':
            ensure => 'directory',
        }
    }

    file {'/usr/local/initial_db/initial_data.json':
        ensure => 'present',
        source => 'puppet:///modules/macaduk/initial_data.json',
        mode   => '0644',
    }

    file {'/usr/local/bin/initial_db.sh':
        ensure => 'present',
        source => 'puppet:///modules/macaduk/initial_db.sh',
        mode   => '0755',
    }

    python::pip { 'requests' :
        pkgname => 'requests',
        ensure  => 'present',
    }

    python::pip { 'pyOpenSSL' :
        pkgname => 'pyOpenSSL',
        ensure  => 'present',
    }

    python::pip { 'ndg-httpsclient' :
        pkgname => 'ndg-httpsclient',
        ensure  => 'present',
    }

    python::pip { 'pyasn1' :
        pkgname => 'pyasn1',
        ensure  => 'present',
    }

}
