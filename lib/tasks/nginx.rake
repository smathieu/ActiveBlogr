namespace :nginx do
  
  desc "start nginx"
  task :start do
    nginx()
  end

  desc "start nginx"
  task :stop do
    nginx('-s stop')
  end
  
  desc "reload nginx"
  task :reload do
    nginx('-s reload')
  end


  def nginx(params='')
    abort "This command is currently only for the development environment." unless Rails.env == 'development'
    config = File.join(RAILS_ROOT, 'config', 'nginx', 'development.conf')
    abort "Nginx configuration not found, copy and modify config/nginx/development.example.conf." unless File.exists?(config)
    sh "sudo /opt/nginx/sbin/nginx -c #{config} " + params
  end
  
end
