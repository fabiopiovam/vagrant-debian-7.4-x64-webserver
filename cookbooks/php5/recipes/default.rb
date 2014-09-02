php_config_file = "/etc/php5/apache2/php.ini"
xdebug_config_file = "/etc/php5/conf.d/xdebug.ini"

puts "********************"
puts "Installing PHP 5 ..."
puts "********************"

package "php5"
package 'php5-cli'
package "libapache2-mod-php5"
package "php5-mcrypt"
package "php-pear"
package 'php5-curl'
package 'php5-gd'
package 'php5-imap'
package 'php5-xdebug'
package 'php5-mysql'
package 'php5-pgsql'

execute "enable display startup errors" do
  not_if "cat #{php_config_file} | grep 'display_startup_errors = On'"
  command "sed -i 's/display_startup_errors = Off/display_startup_errors = On/g' #{php_config_file}"
end

execute "enable display errors" do
  not_if "cat #{php_config_file} | grep 'display_errors = On'"
  command "sed -i 's/display_errors = Off/display_errors = On/g' #{php_config_file}"
end

execute "enable xdebug remote" do
  not_if "cat #{xdebug_config_file} | grep 'xdebug.remote_enable=On'"
  command "echo 'xdebug.remote_enable=On' >> #{xdebug_config_file}"
end

execute "enable xdebug remote connect back" do
  not_if "cat #{xdebug_config_file} | grep 'xdebug.remote_connect_back=On'"
  command "echo 'xdebug.remote_connect_back=On' >> #{xdebug_config_file}"
end

service "apache2" do
  action :reload
end