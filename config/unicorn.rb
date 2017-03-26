# config/unicorn.rb
# Set the working application directory
# working_directory '/path/to/your/app'

working_directory '/home/nomura/rails_test'

# Unicorn PID file location
# pid '/path/to/pids/unicorn.pid'
pid '/var/unicorn/unicorn.pid'

# Path to logs
# stderr_path '/path/to/log/unicorn.log'
# stdout_path '/path/to/log/unicorn.log'

stderr_path '/var/unicorn/unicorn.log'
stdout_path '/var/unicorn/unicorn.log'

# Unicorn socket
# listen '/tmp/unicorn.[application name].sock'

listen '/tmp/unicorn.demo-app.sock'

# Number of processes
# worker_processes 4

worker_processes 2

# Time-out
timeout 30
