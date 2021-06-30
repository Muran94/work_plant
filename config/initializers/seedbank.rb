module Seedbank
  class Runner
    def evaluate(seed_task, seed_file)
      @_seed_task = seed_task
      instance_eval(File.read(seed_file), seed_file)
      puts "Completed seeding! #{seed_file}".cyanish
    rescue => e
      puts "#{e.class} #{e.message}\n".red
      puts "Location is ... #{seed_file}\n"
      puts "#{e.backtrace.join("\n")}\n\n"
    end
  end
end