class macaduk_demo::admin_user {

    user { 'localadmin':
        ensure     => 'present',
        comment    => 'Local Admin',
        gid        => '20',
        groups     => ['admin'],
        home       => '/Users/localadmin',
        iterations => '43478',
        password   => '0fba090f9d54d0017f8844cd22aab2b2e7927688ef682fee3da7ddbf4a22188794fa0559144b981fe624f0d7cc602e13fb39e82ed698663532bb4c16b43a8f7a35d17d8f05fcf6b29df8ca445a979edeb0a9a41096ab4008505e58ffd5935c2ee2cf6f05a1528402ef5cdb833c4e3ad45074ca23fcdcf79b18a78ed342807e42',
        salt       => 'f787d25965c1792a49345420d4876463d46ed4a900826087a3f9bbbd362987c8',
        shell      => '/bin/bash',
        uid        => '502',
    }

    mac_hide_user { 'localadmin':
        ensure  => 'hidden',
        require => User['localadmin']
    }

}
