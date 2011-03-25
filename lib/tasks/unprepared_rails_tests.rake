test_tasks = Rake::Task.tasks.select {|t| t.name =~ /^test/ }
test_tasks.each do |test_task|
  namespace :test do
    desc "#{test_task.comment || test_task.name} without db:prepare"
    task "#{test_task.name.gsub(/^test:/, '')}:nodb" do 
      tt = Rake::Task[test_task.name].dup
      tt.prerequisites.delete("db:test:prepare")
      tt.execute
    end
  end
end
