node.default['system']['packages'] = ['curl','git','vim']

execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
end

puts "************************"
puts "Installing base tools..."
puts "************************"

apt_package "python-software-properties" do
	action :install
end

node['system']['packages'].each do |p|
	apt_package p do
		action :install
	end
end