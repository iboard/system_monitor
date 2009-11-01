namespace :monitor do
  desc "Run remote asserts"
  task :remote => :environment do
    puts sprintf("%-40.40s|%-10.10s| STATUS |# ASSERT COMMAND","NAME","VALUE")
    puts sprintf("%-40.40s+%-10.10s+--------+-------------------------------------","-"*40,"-"*10)
    REMOTE_ASSERTS.each do |ass|
      rc = ass.run
      puts "#{sprintf('%-40.40s',ass.name)}|#{sprintf('%-10.10s',ass.value)}|#{rc ? ' PASSED ' : ' FAILED '}|# #{ass.assert_command(ass.value)}"
    end
  end
  
  desc "Run remote monitors"
  task :monitor => :environment do
    MY_MONITORS.each do |mon|
      puts( (sprintf("== %s ",mon.name) + "="*70)[0..70] )
      mon.run
      puts("\n")
    end
  end
end

