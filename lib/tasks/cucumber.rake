$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty --language pt"
end

task :migrate_schema => 'db:test:purge' do
  ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
  ActiveRecord::Migrator.migrate('db/migrate/')
end

task :features => 'migrate_schema'
