require 'vagrant'
require 'vagrant-mysql/command'
require 'vagrant-mysql/middleware'

# Create a new middleware stack "mysql" which is executed for
# mysql commands. See the VagrantMySQL::Middleware docs for more
# information.
mysql = Vagrant::Action::Builder.new do
  use VagrantMySQL::Middleware
end

Vagrant::Action.register(:mysql, mysql)

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../locales/en.yml", __FILE__)
