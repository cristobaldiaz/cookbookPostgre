#
# Cookbook:: postgres
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
cookbook_file "/opt/pgdg-centos96-9.6-3.noarch.rpm" do
  source "pgdg-centos96-9.6-3.noarch.rpm"
end

package "pgdg-centos96-9.6-3.noarch.rpm" do
  source "/opt/pgdg-centos96-9.6-3.noarch.rpm"
end

package "postgresql96-server"
package "postgresql96-contrib"

execute "initdb" do
  command "/usr/pgsql-9.6/bin/postgresql96-setup initdb"
 # not_if 'test "$(ls -A /var/lib/pgsql/9.6/data/)"'
  not_if { Dir.exists?("/var/lib/pgsql/9.6/data/") && !Dir.empty?('/var/lib/pgsql/9.6/data/') }
end

service "postgresql-9.6" do
  action [:enable, :start]
end
