mysql_root_pwd = "root" # "123456"
mysql_default_db = "dbtest"
mysql_config_file = "/etc/mysql/my.cnf"

puts "***************************"
puts "Installing MySQL Server ..."
puts "***************************"

package "mysql-server"

service "mysql" do
  service_name "mysql"

  supports [:restart, :reload, :status]
  action :enable
end

execute "set the root password" do
  command "/usr/bin/mysqladmin -uroot password #{mysql_root_pwd}" 
  not_if "/usr/bin/mysqladmin -uroot -p#{mysql_root_pwd} status"
end

execute "create the default database" do
  command "/usr/bin/mysql -uroot -p#{mysql_root_pwd} -e 'CREATE DATABASE IF NOT EXISTS #{mysql_default_db}'"
end

execute "grant privileges to the user so that he can get access from the host machine" do 
  command "/usr/bin/mysql -uroot -p#{mysql_root_pwd} -e \"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '#{mysql_root_pwd}' WITH GRANT OPTION;\""
end

execute "sed -i 's/127.0.0.1/0.0.0.0/g' #{mysql_config_file}" do
  not_if "cat #{mysql_config_file} | grep 0.0.0.0"
end

service "mysql" do
  action :restart
end