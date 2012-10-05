#
# Cookbook Name:: collectd_plugins
# Recipe:: carbon_writer
#
# Copyright 2010, Atari, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "collectd"

remote_file File.join(node[:collectd][:plugin_dir], "carbon_writer.py") do
  source "https://raw.github.com/jkerzner/collectd-carbon/master/carbon_writer.py"
  mode "0644"
end

#cookbook_file File.join(node[:collectd][:plugin_dir], "redis.py") do
#  owner "root"
#  group "root"
#  mode "644"
#end


collectd_python_plugin "carbon_writer" do
  options :line_receiver_host => "walrus.pop.umn.edu", :line_receiver_port => "2003", :types_d_b => node[:collectd][:types_db][0]
end
    

#servers = []
#if node[:recipes].include? "redis::server"
#  servers << "localhost"
#else
#  search(:node, 'recipes:"redis::server"') do |server|
#    servers << server["fqdn"]
#  end
#end
#
#collectd_python_plugin "redis" do
#  options :host=>servers, :verbose=>true
#end
