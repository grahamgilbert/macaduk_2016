class macaduk::client {
    file {'/etc/puppetlabs/puppet/csr_attributes.yaml':
        ensure => 'present',
        content => template('macaduk/csr_attributes.yaml.erb')
    }

    host { 'puppet.grahamgilbert.dev':
        ensure       => 'present',
        comment      => 'We don\'t have DNS, so let\'s hack the hosts file',
        host_aliases => 'puppet',
        ip           => '192.168.33.10',
    }
    ini_setting { 'puppet server':
        ensure  => 'present',
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        section => 'main',
        setting => 'server',
        value   => 'puppet.grahamgilbert.dev',
    }
    $certname = downcase($sp_serial_number)
    ini_setting { 'puppet certname':
        ensure  => 'present',
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        section => 'main',
        setting => 'certname',
        value   => $certname,
    }

    file {'/usr':
        ensure => 'directory',
    }

    file {'/usr/local':
        ensure => 'directory',
    }

    file {'/usr/local/bin':
        ensure => 'directory',
    }

    # file {'/usr/local/bin/puppet':
    #     ensure => 'link',
    #     target => '/opt/puppetlabs/bin/puppet',
    # }
    #
    # file {'/usr/local/bin/facter':
    #     ensure => 'link',
    #     target => '/opt/puppetlabs/bin/facter',
    # }


    file {'/private/etc/paths.d':
        ensure => 'directory',
    }

    file {'/private/etc/paths.d/puppet':
        ensure  => 'present',
        content => '/opt/puppetlabs/bin',
        owner   => 'root',
        group   => 'wheel',
        mode    => '0644'
    }

    file {'/opt/puppetlabs/facter':
        ensure => 'directory',
    }

    file {'/opt/puppetlabs/facter/facts.d':
        ensure => 'directory'
    }

    if $sp_serial_number == "VMVJT4IK9FV1"{
        file {'/opt/puppetlabs/facter/facts.d/site.txt':
            ensure  => 'present',
            content => 'site=london'
        }
    }

    service { 'mcollective':
        ensure => 'stopped',
        enable => 'false',
    }

    service { 'puppet':
        ensure => 'stopped',
        enable => 'false',
    }

    service { 'pxp-agent':
        ensure => 'stopped',
        enable => 'false',
    }

    file {'/usr/local/bin/reset.sh':
        ensure => 'present',
        source => 'puppet:///modules/macaduk/clean_client.sh',
        mode   => '0755',
    }
}
