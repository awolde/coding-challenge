#
# Cookbook:: jelk-xenial
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

node.default['java']['jdk_version'] = '8'
include_recipe 'java'

package 'apt-transport-https'

apt_repository 'elasticsearch' do
  uri 'https://artifacts.elastic.co/packages/6.x/apt'
  components ['main']
  distribution 'stable'
  key ['D88E42B4', 'http://artifacts.elastic.co/GPG-KEY-elasticsearch']
  action :add
end

%w(elasticsearch logstash kibana).each do |p|
  package p
end

cookbook_file '/etc/kibana/kibana.yml' do
  source 'kibana.yml'
  owner 'root'
  group 'root'
end

cookbook_file '/etc/logstash/conf.d/logstash-nginxs.conf' do
  source 'logstash-nginx.conf'
  owner 'root'
  group 'root'
end

cookbook_file '/etc/logstash/logstash.yml' do
  source 'logstash.yml'
  owner 'root'
  group 'root'
end

%w(elasticsearch kibana).each do |s|
  service s do
    action [:enable, :start]
  end
end

service 'logstash' do
  action :start
end