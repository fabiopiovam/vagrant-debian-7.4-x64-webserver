puts "*********************"
puts "Installing NodeJS ..."
puts "*********************"

# package "openjdk-7-jdk"
# package "ant"

execute "wget http://nodejs.org/dist/v0.12.0/node-v0.12.0.tar.gz && tar -vzxf node-v0.12.0.tar.gz" do
  # user "root"
  command "cd /usr/local/src && wget http://nodejs.org/dist/v0.12.0/node-v0.12.0.tar.gz && tar -vzxf node-v0.12.0.tar.gz"
  # not_if "echo 'NodeJS already installed!'"
end
 
# Configure seems not to find libssl by default so we give it an explicit pointer.
# Optionally: you can isolate node by adding --prefix=/opt/node
execute "./configure --openssl-libpath=/usr/lib/ssl && make && make install" do
  # user "root"
  command "cd /usr/local/src/node-v0.12.0 && ./configure --openssl-libpath=/usr/lib/ssl && make && make install"
end

execute "Installing JQuery Mobile requirements... " do
  # user "root"
  command "npm install -g grunt-cli"
end

execute "Installing PhoneGap... " do
  # user "root"
  command "npm install -g cordova && npm install -g phonegap"
  not_if "echo 'Error to install PhoneGap'"
end