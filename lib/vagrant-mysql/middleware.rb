module VagrantMySQL
  # A Vagrant middleware which executes a rake task on a given
  # VM. This task will run "mysql" on the VM that this action sequence
  # was run on. If an env variable "mysql.command" is populated, then
  # this command will be executed.
  class Middleware
    def initialize(app, env)
      @app = app
      @env = env
    end

    def call(env)
      if env["vm"].created? && env["vm"].vm.running?
        command = "sudo /etc/init.d/mysql #{env["mysql.command"]}".strip

        env["vm"].ssh.execute do |ssh|
          # env.ui.info I18n.t("vagrant.plugins.mysql.executing", :command => command)

          ssh.exec!("#{command}") do |channel, type, data|
            # Print the data directly to STDOUT, not doing any newlines
            # or any extra formatting of our own
            $stdout.print(data) if type != :exit_status
          end

          # Puts out an ending newline just to make sure we end on a new
          # line.
          $stdout.puts
        end
      end

      @app.call(env)
    end
  end
end
