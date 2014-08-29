# Edit the following to change the name of the database user that will be created:
db_user="admin"
db_pass="123456"

# Edit the following to change the version of PostgreSQL that is installed
pg_version=9.1

pg_conf="/etc/postgresql/#{pg_version}/main/postgresql.conf"
pg_hba="/etc/postgresql/#{pg_version}/main/pg_hba.conf"
pg_dir="/var/lib/postgresql/#{pg_version}/main"

puts "************************************"
puts "Installing PostgreSQL #{pg_version} ..."
puts "************************************"

package "postgresql-#{pg_version}"

service "postgresql" do
  supports [:restart]
  action :enable
end

execute "Edit postgresql.conf to change listen address to '*'" do
  command "sed -i \"s/#listen_addresses = 'localhost'/listen_addresses = '*'/\" #{pg_conf}"
end

template "#{pg_hba}" do
  source "pg_hba.conf"
  owner "root"
  mode "0755"
  notifies :restart, "service[postgresql]"
end

execute "create #{db_user} user" do
  command "psql -d template1 -c 'create user #{db_user};'"
  user "postgres"
  action :run
  not_if "psql -d template1 -tAc \"SELECT * FROM pg_roles WHERE rolname='#{db_user}'\" | grep -q #{db_user}", :user => 'postgres'
end

execute "set #{db_user} user password" do
  command "psql -d template1 -c \"alter user #{db_user} with password '#{db_pass}';\""
  user "postgres"
  action :run
end

execute "grant #{db_user} user all the rights" do
  command "psql -d template1 -c \"GRANT SELECT ON pg_shadow TO #{db_user};\""
  user "postgres"
  action :run
end