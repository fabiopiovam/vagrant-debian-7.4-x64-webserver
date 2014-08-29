vagrant-debian-7.4-x64-webserver
================================

Mi chef-solo cookbook que contiene configuraciones para servidor web

Recipes
-------
* LAMP (PHP 5.4)
* Postgres 9.1
* Python with pip and virtualenv

Instalación y uso
-----------------

1. Clone el proyecto

    ``` sh
    $ git clone https://github.com/laborautonomo/vagrant-debian-7.4-x64-webserver.git
    $ cd vagrant-debian-7.4-x64-webserver
    ``` 

2. Altere el `Vagrantfile` con sus preferencias

3. Configure la contraseña del root MySQL em `cookbooks/mysql/recipes/default.rb`

    ``` ruby
    mysql_root_pwd = "your-password"
    ``` 

4. Configure el Postgres en `cookbooks/postgres/recipes/default.rb`

    ``` ruby
    # Edit the following to change the name of the database user that will be created:
	db_user="user-name"
	db_pass="your-password"
	
	# Edit the following to change the version of PostgreSQL that is installed
	pg_version=9.1
    ```

5. Configure los hosts y doc_roots de sus proyectos en `cookbooks/apache2/recipes/sites_available.rb`

	``` ruby
    SITES_AVAILABLE = [
		{:server_name => 'host1',:doc_root => 'website1'},
		{:server_name => 'host2', :doc_root => 'website2'},
		...
	]
    ```

6. Finalmente, ejecute `vagrant up --provision`

Referências
------------
* [erikaheidi/vagrantcookbook](https://github.com/erikaheidi/vagrantcookbook)
* [kitchenplan/vagrant-chef-kdeploy](https://github.com/kitchenplan/vagrant-chef-kdeploy)
* [Chef Doc](http://docs.getchef.com/)
* [gordonlesti.com](http://gordonlesti.com/developing-with-vagrant-part-2/)

Agradecimientos
---------------
* [kaiocesar](https://github.com/kaiocesar)
