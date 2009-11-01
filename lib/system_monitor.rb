module SystemMonitor
  
  class SysMonitor < Struct.new(:host,:name,:method,:options)
    
    def state
      run
    end
    
    def run
      if host == 'localhost'
        eval "self.#{method}"
      else
        cmd = "ssh #{host} #{method} #{options}"
        p = File::popen(cmd,'r')
        t = p.read
        p.close
        puts t
      end
    end
    
    def diskusage
      p=File::popen("du -hs #{options}",'r')
      r=p.read
      p.close
      r.gsub(/^(.*)$/, " "*8+'   \1')
    end
    
    def execute_remote(cmd)
      p=File::popen(cmd, 'r')
      r=p.read
      p.close 
      r
    end
    
  end
  
  class RemoteAssert < Struct.new(:host,:name,:method,:word,:command,:recipients,:subject)
    attr_reader :value,:state,:response
    
    def run
      cmd = "ssh #{host} #{method}"
      p=File::popen(cmd,'r')
      @response=p.read
      p.close
      s=@response.split(/\s+/)
      @value = s[word]
      acmd = "" + assert_command(s[word]) + ""
      @state = eval( acmd )
      alert unless @state
      @state
    end
    
    
    
    def assert_command(avalue)
      command.gsub("INTEGER",avalue.to_i.to_s).gsub("STRING","'"+(avalue||"")+"'").gsub("FLOAT",avalue.to_f.to_s)
    end
    
    def alert
      hostname = `hostname`
      Notifier::deliver_alert("noreply@#{hostname}",recipients,"FAILED MONITOR: #{name}",
        "FAILED WITH VALUE <b>#{value}</b> WHEN ASSERTING <code>#{command}</code>\n"+
        "COMMAND <code>#{method}</code> RAN AT <b>#{host}</b> USING WORD #<b>#{word}</b>",
        self
      )
      puts "** MAIL SENT TO #{recipients} WITH SUBJECT #{subject} **"
    end
  end
  
  
end