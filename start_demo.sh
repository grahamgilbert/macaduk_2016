#!/bin/bash

vagrant destroy -f
vagrant up puppetserver
vagrant provision puppetserver
vagrant up client1
vagrant up client2
vagrant ssh puppetserver
vagrant rsync-auto puppetserver
