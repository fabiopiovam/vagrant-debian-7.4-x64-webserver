vagrant-debian-7.4-x64-webserver
================================

My chef-solo cookbook with webserver configuration

Recipes
-------
* LAMP (PHP 5.4)
* Postgres 9.1
* Python with pip and virtualenv

Requirements
------------
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) `# aptitude install virtualbox`
* [Vagrant >=1.6.1](http://www.vagrantup.com/downloads.html)
* [NFS](http://en.wikipedia.org/wiki/Network_File_System) `# aptitude install nfs-kernel-server nfs-common`

Installation / Usage
--------------------

1. Clone the project

    ``` sh
    $ git clone https://github.com/laborautonomo/vagrant-debian-7.4-x64-webserver.git
    $ cd vagrant-debian-7.4-x64-webserver
    ``` 

2. Change `Vagrantfile` with your preferences

    ``` ruby
    config.vm.box = "chef/debian-7.4"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "private_network", ip: "192.168.33.102"
    config.vm.post_up_message = "Your environment is ready and accessible in http://192.168.33.102"
    config.vm.synced_folder "/var/www", "/vagrant", type: "nfs"
  
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    ``` 

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

5. Configure Apache2 default values of vhost in `cookbooks/apache2/recipes/default.rb`
	
	``` ruby
    node.default['apache']['server_name'] = "192.168.33.102"
	node.default['apache']['server_admin'] = "your@email"
	node.default['apache']['doc_root'] = "/vagrant"
    ```
	
6. Configure the hosts and doc_roots of your websites in `cookbooks/apache2/recipes/sites_available.rb`

	``` ruby
    SITES_AVAILABLE = [
		{:server_name => 'host1',:doc_root => 'website1'},
		{:server_name => 'host2', :doc_root => 'website2'},
		...
	]
    ```

7. Finally, execute `vagrant up --provision`

References
----------
* [erikaheidi/vagrantcookbook](https://github.com/erikaheidi/vagrantcookbook)
* [kitchenplan/vagrant-chef-kdeploy](https://github.com/kitchenplan/vagrant-chef-kdeploy)
* [Chef Doc](http://docs.getchef.com/)
* [gordonlesti.com](http://gordonlesti.com/developing-with-vagrant-part-2/)

Acknowledgment
--------------
* [kaiocesar](https://github.com/kaiocesar)
