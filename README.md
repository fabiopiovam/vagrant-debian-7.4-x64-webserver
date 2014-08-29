vagrant-debian-7.4-x64-webserver
================================

My chef-solo cookbook with webserver configuration

Features Include
----------------
* LAMP (PHP 5.4)
* Postgres 9.1
* Python with pip and virtualenv

Installation / Usage
--------------------

1. Clone the project

    ``` sh
    $ git clone https://github.com/laborautonomo/vagrant-debian-7.4-x64-webserver.git
    $ cd vagrant-debian-7.4-x64-webserver
    ``` 

2. Alter `Vagrantfile` with your preferences

3. Configure the MySQL root password in `cookbooks/mysql/recipes/default.rb`

    ``` ruby
    mysql_root_pwd = "your-password"
    ``` 

4. Configure Postgres in `cookbooks/postgres/recipes/default.rb`

    ``` ruby
    # Edit the following to change the name of the database user that will be created:
	db_user="user-name"
	db_pass="your-password"
	
	# Edit the following to change the version of PostgreSQL that is installed
	pg_version=9.1
    ```

5. Configure the hosts and doc_roots of your websites in `cookbooks/apache2/recipes/sites_available.rb`

	``` ruby
    SITES_AVAILABLE = [
		{:server_name => 'host1',:doc_root => 'website1'},
		{:server_name => 'host2', :doc_root => 'website2'},
		...
	]
    ```

6. Finally, execute `vagrant up --provision`

References
----------
*[erikaheidi/vagrantcookbook](https://github.com/erikaheidi/vagrantcookbook)
*[kitchenplan/vagrant-chef-kdeploy](https://github.com/kitchenplan/vagrant-chef-kdeploy)
*[Chef Doc](http://docs.getchef.com/)
*[gordonlesti.com](http://gordonlesti.com/developing-with-vagrant-part-2/)

Acknowledgment
--------------
*[kaiocesar](https://github.com/kaiocesar)
