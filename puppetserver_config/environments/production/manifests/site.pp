node 'puppet.grahamgilbert.dev' {
    class {'::macaduk': } ->
    class { '::puppet':
      server                      => true,
      runmode                     => 'none',
      server_foreman              => false,
      server_implementation       => 'puppetserver',
      autosign                    => '/sal_cert.py',
      server_external_nodes       => '',
      show_diff                   => true,
      server_reports              => 'puppetdb,store',
      server_storeconfigs_backend => 'puppetdb',
      hiera_config                => '$codedir/hiera.yaml',
      server_template => 'macaduk/puppet.conf.master.erb'
    }

    class { 'puppetboard':
        manage_git      => 'latest',
        dev_listen_host => '0.0.0.0',
        git_source      => 'https://github.com/voxpupuli/puppetboard'
    } ->
    class { 'supervisord':
        install_pip => true,
    } ->
    supervisord::program { 'puppetboard':
        command  => 'python /srv/puppetboard/puppetboard/dev.py',
        priority => '100',
        program_environment => {
            'HOME'                 => '/home/vagrant',
            'PATH'                 => '/srv/puppetboard/virtenv-puppetboard/bin/:/bin:/sbin:/usr/bin:/usr/sbin',
            'PUPPETBOARD_SETTINGS' => '/srv/puppetboard/puppetboard/settings.py'
        }
    } ->

    class { 'docker':
        version       => 'latest',
    } ->

    firewall { '100 Allow sal and nginx':
        dport   => ['80', '8000'],
        proto  => 'tcp',
        action => 'accept',
    } ->

    docker::image { 'grahamgilbert/postgres':
        image_tag => 'latest'
    } ->

    docker::run { 'sal-postgres':
        image           => 'grahamgilbert/postgres',
        volumes         => ['/usr/local/docker/db:/var/lib/postgresql/data'],
        env             => ['DB_NAME=password', 'DB_USER=admin', 'DB_PASS=password'],
        restart_service => true,
        pull_on_start   => true,
        require         => Docker::Image['grahamgilbert/postgres'],
    } ->

    docker::image { 'macadmins/sal':
        image_tag => 'latest'
    } ->

    docker::run { 'sal':
        image           => 'macadmins/sal',
        env             => ['DB_NAME=password', 'DB_USER=admin', 'DB_PASS=password'],
        volumes         => ['/usr/local/initial_db:/initial_db'],
        restart_service => true,
        pull_on_start   => true,
        ports           => ['8000:8000'],
        links           => ['sal-postgres:db'],
        depends         => ['sal-postgres'],
        require         => Docker::Image['macadmins/sal'],
    } ->

    docker::image { 'nginx':
        image_tag => 'latest'
    } ->

    docker::run { 'munki':
        image           => 'nginx',
        volumes         => ['/usr/local/docker/munki:/usr/share/nginx/html'],
        restart_service => true,
        pull_on_start   => true,
        ports           => ['80:80'],
        require         => Docker::Image['nginx'],
    }

    # Configure puppetdb and its underlying database
    class { 'puppetdb':
        # database => 'embedded',
        # disable_ssl => true,
    }
    # # Configure the puppet master to use puppetdb
    class { 'puppetdb::master::config':
        #puppetdb_port   => 8080,
    }

    cron { chmod0:
        command => "/bin/chmod -R 777 /etc/puppetlabs/code",
        user    => 'root',
        hour    => '*',
        minute  => '*',
        require => Class['puppetdb'],
    }

    cron { chmod10:
        command => "sleep 10; /bin/chmod -R 777 /etc/puppetlabs/code",
        user    => 'root',
        hour    => '*',
        minute  => '*',
        require => Class['puppetdb'],
    }

    cron { chmod20:
        command => "sleep 20; /bin/chmod -R 777 /etc/puppetlabs/code",
        user    => 'root',
        hour    => '*',
        minute  => '*',
        require => Class['puppetdb'],
    }

    cron { chmod30:
        command => "sleep 30; /bin/chmod -R 777 /etc/puppetlabs/code",
        user    => 'root',
        hour    => '*',
        minute  => '*',
        require => Class['puppetdb'],
    }

    cron { chmod40:
        command => "sleep 40; /bin/chmod -R 777 /etc/puppetlabs/code",
        user    => 'root',
        hour    => '*',
        minute  => '*',
        require => Class['puppetdb'],
    }

    cron { chmod50:
        command => "sleep 50; /bin/chmod -R 777 /etc/puppetlabs/code",
        user    => 'root',
        hour    => '*',
        minute  => '*',
        require => Class['puppetdb'],
    }

    # exec {'/usr/local/bin/initial_db.sh':
    #     require => Docker::Run['sal'],
    # }

}

node 'client1.grahamgilbert.dev', 'client2.grahamgilbert.dev' {
    class {'macaduk::client': }
}
