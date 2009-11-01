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
  
  class RemoteAssert < Struct.new(:host,:name,:method,:word,:command)
    attr_reader :value
    def run
      cmd = "ssh #{host} #{method}"
      p=File::popen(cmd,'r')
      r=p.read
      p.close
      s=r.split(/\s+/)
      @value = s[word]
      acmd = "" + assert_command(s[word]) + ""
      eval( acmd )
    end
    
    def assert_command(avalue)
      command.gsub("INTEGER",avalue.to_i.to_s).gsub("STRING","'"+(avalue||"")+"'").gsub("FLOAT",avalue.to_f.to_s)
    end
  end
  
  
end