# coding challenge

This repo will create two vagrant boxes.

One with ELK stack, and the other one with Nginx and filebeat configured to send logs to the ELK stack.

## Setup
You will need [Vagrant](https://www.vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed and configured.

Clone this repo and do
```
vagrant up --provision
```

This will provision both vms and configure them with Chef cookbooks located in `cookbooks` directory.

This is only tested in Ubuntu 16 Xenial 64-bit.

## Logging to Console
Nginx node is accessed via http://localhost:8080.

Kibana is accessed via http://localhost:8090.

These settings are configured on `Vagrantfile`.

## Cookbook setup
Java cookbook and its denpendcies (windows and homebrew) are from [Chef supermarket](https://supermarket.chef.io/).

There is no need for chef server, this runs in chef zero mode.

The cookbooks `elk-xenial` and `nginx-filebeat` will override the default version of JDK and install and configure necessary packages.

This is a minimal setup, config files are hard coded and stored in `files/default` directories of the above two cookbooks. They can be
changed to template files if the need arises.