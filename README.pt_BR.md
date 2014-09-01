vagrant-debian-7.4-x64-webserver
================================

Meu chef-solo cookbook que contém configurações para servidor web

Recipes
-------
* LAMP (PHP 5.4)
* Postgres 9.1
* Python with pip and virtualenv

Requerimentos
-------------
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 
	* `# aptitude install virtualbox`
* [Vagrant >=1.6.1](http://www.vagrantup.com/downloads.html)
* [NFS](http://pt.wikipedia.org/wiki/Network_File_System) 
	* `# aptitude install nfs-kernel-server nfs-common`

Instalação e uso
----------------

1. Clone o projeto

    ``` sh
    $ git clone https://github.com/laborautonomo/vagrant-debian-7.4-x64-webserver.git
    $ cd vagrant-debian-7.4-x64-webserver
    ``` 

2. Altere o `Vagrantfile` com suas preferencias

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

3. Configure a senha do usuário root do MySQL em `cookbooks/mysql/recipes/default.rb`

    ``` ruby
    mysql_root_pwd = "your-password"
    ``` 

4. Configure o Postgres em `cookbooks/postgres/recipes/default.rb`

    ``` ruby
    # Edit the following to change the name of the database user that will be created:
	db_user="user-name"
	db_pass="your-password"
	
	# Edit the following to change the version of PostgreSQL that is installed
	pg_version=9.1
    ```

5. Configure os valores padrão do Apache2 - vhost em `cookbooks/apache2/recipes/default.rb`
	
	``` ruby
    node.default['apache']['server_name'] = "192.168.33.102"
	node.default['apache']['server_admin'] = "your@email"
	node.default['apache']['doc_root'] = "/vagrant"
    ```

6. Configure os hosts e doc_roots dos seus projetos em `cookbooks/apache2/recipes/sites_available.rb`

	``` ruby
    SITES_AVAILABLE = [
		{:server_name => 'host1',:doc_root => 'website1'},
		{:server_name => 'host2', :doc_root => 'website2'},
		...
	]
    ```

7. Por fim, execute `vagrant up --provision`

Referências
------------
* [erikaheidi/vagrantcookbook](https://github.com/erikaheidi/vagrantcookbook)
* [kitchenplan/vagrant-chef-kdeploy](https://github.com/kitchenplan/vagrant-chef-kdeploy)
* [Chef Doc](http://docs.getchef.com/)
* [gordonlesti.com](http://gordonlesti.com/developing-with-vagrant-part-2/)

Agradecimentos
--------------
* [kaiocesar](https://github.com/kaiocesar)
