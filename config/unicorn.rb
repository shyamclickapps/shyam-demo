root = "/var/www/html/shyam-demo/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen 3045
worker_processes 5
timeout 30
