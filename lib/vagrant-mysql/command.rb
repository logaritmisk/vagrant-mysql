module VagrantMySQL
  class Command < Vagrant::Command::Base
    register "mysql", "Run a mysql command inside the VM environment"
    argument :mysql_command, :type => :string, :required => false, :desc => "The mysql command to run on the VM"

    # Executes the given rake command on the VMs that are represented
    # by this environment.
    def execute
      target_vms.each { |vm| execute_on_vm(vm, mysql_command) }
    end

    protected

    # Executes a command on a specific VM.
    def execute_on_vm(vm, command)
      vm.env.actions.run(:mysql, "mysql.command" => command)
    end
  end
end
