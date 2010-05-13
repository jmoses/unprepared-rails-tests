# Rake.application.remove_task 'db:test:prepare'

puts "BEING REQUIRED"

test_tasks = Rake::Task.tasks.select {|t| t.comment && t.name =~ /^test/ }
test_tasks.each do |test_task|
  namespace :test do
    desc "#{test_task.comment} without db:prepare"
    task "#{test_task.name.gsub(/^test:/, '')}:nodb" do 
      tt = Rake::Task[test_task.name].dup
      tt.clear_prerequisites
      tt.execute
    end
  end
end