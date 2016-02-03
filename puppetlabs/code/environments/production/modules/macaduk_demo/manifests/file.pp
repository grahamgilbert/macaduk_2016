class macaduk_demo::file {
    file { '/Users/Shared/puppet_created.txt':
        ensure  => 'present',
        owner   => '501',
        group   => '80',
        mode    => '0777',
        content => 'Master of Puppets, I\'m pulling your strings.'
    }
}
