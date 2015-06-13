namespace :dj do
  desc "Boot the workers"
  task :on_boot do
    `bin/delayed_job start`
  end
end
