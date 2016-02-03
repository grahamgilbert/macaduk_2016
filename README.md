# Requirements

To use this, you will need:

* [Vagrant](http://vagrantup.com)
* [VMware Fusion](http://www.vmware.com/uk/products/fusion)
* [The VMware plugin](https://www.vagrantup.com/vmware/)
* [An OS X box for Vagrant](http://www.vmware.com/uk/products/fusion)

This will stand up:

* A Puppet server, with Puppet DB
* [Sal](http://salopensource.com), running on Docker on port 8000
* [Puppetboard](https://github.com/voxpupuli/puppetboard) running on port 5000

The Puppet server is configured to use Sal for certificate signing. You will need to use [this package](https://github.com/grahamgilbert/Puppet-CSRAttributes) on your OS X clients to use this feature, otherwise you will need to sign the certificates manually.

# The directories

``puppetlabs/code`` contains the Puppet code that will configure your clients. ``puppetserver_config`` contains the Puppet code to configure the Puppetserver and the test client to be able to connect to the Puppetserver (hosts file modification mainly. The Puppet Launch Daemon is disabled as well for demo purposes).

# Usage

``` bash
$ vagrant up puppetserver
# It's not fully configured yet, need to provision again
$ vagrant provision puppetserver
$ vagrant up client1
```
