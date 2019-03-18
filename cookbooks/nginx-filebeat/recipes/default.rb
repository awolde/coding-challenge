node.default['java']['jdk_version'] = '8'
include_recipe "java"

apt_repository 'elasticsearch' do
  uri 'https://artifacts.elastic.co/packages/6.x/apt'
  components ['main']
  distribution 'stable'
  key ['D88E42B4', 'http://artifacts.elastic.co/GPG-KEY-elasticsearch']
  action :add
end

%w(nginx filebeat).each do |p|
  package p
end

cookbook_file '/etc/filebeat/filebeat.yml' do
  source 'filebeat.yml'
  owner 'root'
  group 'root'
end

%w(filebeat nginx).each do |s|
  service s do
    action [:enable, :start]
  end
end
