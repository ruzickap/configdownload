

# Sample XML file

```
<configuration>                                                             
  <cisco_telnet_1>                                                          
      <commands_after>enable</commands_after>                               
      <commands_after>terminal length 0</commands_after>                    
      <commands_after>show version</commands_after>                         
      <commands_after>show run</commands_after>                             
      <commands_after>show ip interface brief</commands_after>              
      <commands_after>copy system:/running-config tftp://192.168.0.16/      

      </commands_after>
<!--                   
### Console Router (Cisco 2811)
-->                            
    <testbb0rt01 host="192.168.0.57" port="23" username="admin" password="mypass" enable_password="myenapass" login_timeout="1" output_log="./testbb0rt01-192.168.0.57.log" login_prompt='(?m:^Please enter your selection:\s*$)'>                                                                                                                              
      <commands timeout="1">x</commands>                                                                                                                                        
      <commands>show cdp neighbors</commands>                                                                                                                                   
      <commands>show cdp neighb detail</commands>                                                                                                                               
      <commands>show interface status</commands>                                                                                                                                
    </testbb0rt01>                                                                                                                                                              
<!--                                                                                                                                                                            
### 4948-HSRP-1 (Cisco 4948)                                                                                                                                                    
-->                                                                                                                                                                             
    <testbb0sw02 host="192.168.0.61" port="23" username="admin" password="mypass" enable_password="myenapass">                                                                  
      <commands>show ip route</commands>                                                                                                                                        
      <commands>show ip ospf</commands>                                                                                                                                         
      <commands>show cdp neighbors</commands>                                                                                                                                   
      <commands>show cdp neighb detail</commands>                                                                                                                               
      <commands>show interface status</commands>                                                                                                                                
    </testbb0sw02>                                                                                                                                                              
    <testbb0sw01 host="192.168.0.60" port="23" username="admin" password="mypass" enable_password="myenapass">                                                                  
      <commands>show ip route</commands>                                                                                                                                        
      <commands>show ip ospf</commands>                                                                                                                                         
      <commands>show cdp neighbors</commands>                                                                                                                                   
      <commands>show cdp neighb detail</commands>                                                                                                                               
      <commands>show interface status</commands>                                                                                                                                
    </testbb0sw01>                                                                                                                                                              
  </cisco_telnet_1>                                                                                                                                                             


  <cisco_telnet_2-lb>
    <commands_after>terminal length 65535</commands_after>
    <commands_after>show version</commands_after>         
    <commands_after>show chassis</commands_after>         
    <commands_after>show virtual-routers</commands_after> 
    <commands_after>show redundant-vips</commands_after>  
    <commands_after>show interface</commands_after>       
    <commands_after>show phy</commands_after>             
    <commands_after>show circuits all</commands_after>    
    <commands_after>show ip route</commands_after>        
    <commands_after>show ip interfaces</commands_after>   
    <commands_after>show service summary</commands_after> 
    <commands_after>show session-redundant all</commands_after>
    <commands_after>show rule-summary</commands_after>         
    <commands_after>show summary</commands_after>              
    <commands_after>show boot-config</commands_after>          
    <commands_after>show run</commands_after>                  
    <commands_after>copy script ap-kal-tcp-ports tftp 192.168.0.16 ap-kal-tcp-ports</commands_after>
<!--                                                                                                
### LB CSS 11501/11503 (Cisco 11503 LB)                                                             
-->                                                                                                 
    <testbb0lb01 host="192.168.0.58" port="23" username="admin" password="mypass">                  
      <commands>copy running-config tftp 192.168.0.16 testbb0lb01-confg</commands>                  
      <commands>copy log boot.log tftp 192.168.0.16 testbb0lb01/boot.log</commands>                 
      <commands>copy log sys.log  tftp 192.168.0.16 testbb0lb01/sys.log</commands>                  
      <commands>copy log traplog  tftp 192.168.0.16 testbb0lb01/traplog</commands>                  
    </testbb0lb01>                                                                                  
    <testbb0lb02 host="192.168.0.59" port="23" username="admin" password="mypass">                  
      <commands>copy running-config tftp 192.168.0.16 testbb0lb02-confg</commands>                  
      <commands>copy log boot.log tftp 192.168.0.16 testbb0lb02/boot.log</commands>                 
      <commands>copy log sys.log  tftp 192.168.0.16 testbb0lb02/sys.log</commands>                  
      <commands>copy log traplog  tftp 192.168.0.16 testbb0lb02/traplog</commands>                  
    </testbb0lb02>                                                                                  
  </cisco_telnet_2-lb>                                                                              


  <ssh_sw>
    <commands_before timeout="1" prompt='\s*[Pp]assword:\s*'>enable</commands_before>
    <commands_before>myenapass</commands_before>                                     
    <commands_before>terminal length 0</commands_before>                             
    <commands_before>show version</commands_before>                                  
    <commands_before>show run</commands_before>                                      
    <commands_before>copy system:/running-config tftp://192.168.0.16/                

    </commands_before>
<!--                  
### 2960G-24 (Cisco 2960G)
-->                       
    <testbb0sw04 host="192.168.0.56" port="22" username="admin" password="mypass" timeout="1" output_file="./testbb0sw04-192.168.0.52.log" ssh_options="-v" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' password_prompt='[Pp]assword.*?:|[Pp]assphrase.*?:' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                                                                        
    </testbb0sw04>                                                                                                                                                              
    <testbb0sw03 host="192.168.0.55" port="22" username="admin" password="mypass" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                      
    </testbb0sw03>                                                                                                                                                              
<!--                                                                                                                                                                            
### Enclosure c7000: CISCO Catalyst Blade Switch 3020                                                                                                                           
-->                                                                                                                                                                             
    <testen0sw01 host="192.168.0.67" port="22" username="admin" password="mypass" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                      
    </testen0sw01>                                                                                                                                                              
    <testen0sw02 host="192.168.0.68" port="22" username="admin" password="mypass" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                      
    </testen0sw02>                                                                                                                                                              
    <testen0sw03 host="192.168.0.71" port="22" username="admin" password="mypass" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                      
    </testen0sw03>                                                                                                                                                              
    <testen0sw04 host="192.168.0.72" port="22" username="admin" password="mypass" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                      
    </testen0sw04>                                                                                                                                                              
    <testen0sw05 host="192.168.0.73" port="22" username="admin" password="mypass" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                      
    </testen0sw05>                                                                                                                                                              
    <testen0sw06 host="192.168.0.74" port="22" username="admin" password="mypass" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                      
    </testen0sw06>                                                                                                                                                              
  </ssh_sw>                                                                                                                                                                     


  <ssh_sa>
    <commands_before>wwn</commands_before>
    <commands_before>switchshow</commands_before>
    <commands_before>licenseidshow</commands_before>
    <commands_before>cfgshow</commands_before>      
    <commands_before>sensorshow</commands_before>   
    <commands_before>chassisshow</commands_before>  
    <commands_before>portcfgshow</commands_before>  
    <commands_before>sfpshow</commands_before>      
    <commands_before>nsshow</commands_before>       
    <commands_before>porterrshow</commands_before>  
    <commands_before>ifmodeshow eth0</commands_before>
    <commands_before timeout="10">supportshow exception fabric network</commands_before>
<!--                                                                                    
### Enclosure c7000: Brocade 4Gb SAN Switch                                             
-->                                                                                     
    <testen0sa01 host="192.168.0.69" port="22" username="admin" password="adminsa">     
      <commands prompt=".*password:\s*" >configupload -all -scp 192.168.0.16,root,/tftpboot/testen0sa01.cfg</commands>
      <commands>adminman</commands>                                                                                   
    </testen0sa01>                                                                                                    
    <testen0sa02 host="192.168.0.70" port="22" username="admin" password="adminsa">                                   
      <commands prompt=".*password:\s*" >configupload -all -scp 192.168.0.16,root,/tftpboot/testen0sa02.cfg</commands>
      <commands>adminman</commands>                                                                                   
    </testen0sa02>                                                                                                    
  </ssh_sa>                                                                                                           


  <ssh_en>
    <commands_before timeout="10">show all</commands_before>
    <commands_before>upload config tftp://192.168.0.16/testen0mn01.cfg</commands_before>
<!--                                                                                    
### Enclosure c7000: HP Onboard Administrator                                           
-->                                                                                     
    <testen0mn01 host="192.168.0.65" port="22" username="admin" password="adminsa" timeout="2">
    </testen0mn01>                                                                             
  </ssh_en>                                                                                    


  <http_file_get>
<!--             
### Video Gateway: Radvision (Scopia 400)
-->                                      
    <testvm0mg02 host="192.168.0.51" port="80" get_file="/goform/gwcfg.ini" output_file="testvm0mg02-192.168.0.51.ini" />
    <testvm0mg01 host="192.168.0.50" get_file="/goform/gwcfg.ini" output_file="testvm0mg01-192.168.0.50.ini" />          
  </http_file_get>                                                                                                       


  <ftp_recursive_get>
<!--                 
### Dialogic DSI SS7G32 Signaling Servers
-->                                      
    <testvm0sg02 host="192.168.0.49" username="siuftp" password="siuftp" remote_directory='.' local_directory='./testvm0sg02' timeout="12" />
    <testvm0sg01 host="192.168.0.48" username="siuftp" password="siuftp" local_directory='./testvm0sg01' />                                  
  </ftp_recursive_get>                                                                                                                       
  <telnet>                                                                                                                                   
      <commands_before>ALLIP;</commands_before> <!-- Alarm List PrintReset -->                                                               
      <commands_before>STSLP;</commands_before> <!-- Status Signalling Link Print -->                                                        
      <commands_before>STPCP;</commands_before> <!-- Status PCM Print -->                                                                    
      <commands_before>STBOP;</commands_before> <!-- Status Board Print -->                                                                  
      <commands_before>STRLP;</commands_before> <!-- Status Remote SIU Link Print -->                                                        
      <commands_before>STHLP;</commands_before> <!-- Status Host Link Print -->
      <commands_before>STCGP;</commands_before> <!-- Status Circuit Group Print -->
      <commands_before>STCRP;</commands_before> <!-- Status SS7 Route Print -->
      <commands_before>STEPP;</commands_before> <!-- Status of Ethernet Port Print -->
      <commands_before>STALP;</commands_before> <!-- Status Alarm Print -->
      <commands_before>STSYP;</commands_before> <!-- Status System Print -->
      <commands_before>STSTP;</commands_before> <!-- Status Sigtran Links Print -->
      <commands_before>STSRP;</commands_before> <!-- Status of Sigtran Route Print -->
      <commands_before>STRAP;</commands_before> <!-- Status of Remote Application Server Print -->
      <commands_before>STLCP;</commands_before> <!-- Status Software License Print -->
      <commands_before>CNSWP;</commands_before> <!-- Configuration Software Print -->
      <commands_before>CNSYP;</commands_before> <!-- Configuration System Print -->
      <commands_before>CNCGP;</commands_before> <!-- Configuration Circuit Group Print -->
      <commands_before>CNTDP;</commands_before> <!-- Configuration Time and Date Print -->
      <commands_before>CNCRP;</commands_before> <!-- Configuration MTP route print -->
      <commands_before>CNCSP;</commands_before> <!-- Configuration Concerned Sub-system Print -->
      <commands_before>CNSNP;</commands_before> <!-- Configuration SNMP Print -->
      <commands_before>CNSRP;</commands_before> <!-- Configuration of Sigtran Route Print -->
      <commands_before>CNGLP;</commands_before> <!-- Configuration Gateway List Print -->
      <commands_before>CNTPP;</commands_before> <!-- Configuration Network me Protocol Print -->
      <commands_before>STTPP;</commands_before> <!-- Network Time Protocol Status Print -->
      <commands_before>CNSMP;</commands_before> <!-- Configuration SNMP Print -->
      <commands_before>CNUSP;</commands_before> <!-- Confiugration SNMP User Account Print -->
      <commands_before>CNOBP;</commands_before> <!-- Configuration SNMP Traps Print -->
      <commands_before>CNGPP;</commands_before> <!-- Configuration GTT Pattern Print -->
      <commands_before>CNGAP;</commands_before> <!-- Configuration GTT Address Print -->
      <commands_before>IPGWP;</commands_before> <!-- Internet Protocol Gateway Print -->
      <commands_before>IPEPP;</commands_before> <!-- Internet Protocol Ethernet Port PrintMeasurement -->
      <commands_before>MSSYP;</commands_before> <!-- Measurement System Print -->
      <commands_before>MSPCP;</commands_before> <!-- Measurement PCM Print -->
      <commands_before>MSSLP;</commands_before> <!-- Measurement SS7 Link Print -->
      <commands_before>MSEPP;</commands_before> <!-- Measurement Ethernet Port Print -->
      <commands_before>MSSTP;</commands_before> <!-- Measurements Sigtran Links Print -->
      <commands_before>MSLCP;</commands_before> <!-- Measurement Software License Print -->
<!--
### Video SS7 Gateway: Radvision (SS7G2)
-->
    <testvm0sg02 host="127.0.0.1" port="8100" login_timeout="1" timeout="1" output_log="./testvm0sg02-192.168.0.49.log" prompt='&lt;'>
    </tnmevm0sg02>
  </telnet>
</configuration>
```

# Example of executing config\_download.pl

```
/tmp/config_download-0.1[su]# ls                                                         
config_download.pl  config-sample.xml  config-test.xml  config.xml  LICENSE  modules  README  samples
/tmp/config_download-0.1[su]# mc -e config-sample.xml                                                

/tmp/config_download-0.1[su]# mkdir /tmp/config
/tmp/config_download-0.1[su]# ./config_download.pl ./config-sample.xml --destination=/tmp/config

***| [1/4] cisco_telnet_1 testbb0rt01 192.168.0.57:23 
***| x [1]                                            
***| show cdp neighbors [15]                          
***| show cdp neighb detail [15]                      
***| show interface status [15]                       
***| terminal length 0 [15]                           
***| show version [15]                                
***| show run [15]                                    
***| show ip interface brief [15]                     
***| copy system:/running-config tftp://192.168.0.16/ 

       [15]

***| [2/4] cisco_telnet_1 testbb0sw01 192.168.0.60:23 
***| show ip route [15]                               
***| show ip ospf [15]                                
***| show cdp neighbors [15]                          
***| show cdp neighb detail [15]                      
***| show interface status [15]                       
***| terminal length 0 [15]                           
***| show version [15]                                
***| show run [15]                                    
***| show ip interface brief [15]                     
***| copy system:/running-config tftp://192.168.0.16/ 

       [15]

***| [3/4] cisco_telnet_1 testbb0sw02 192.168.0.61:23 
***| show ip route [15]                               
***| show ip ospf [15]                                
***| show cdp neighbors [15]                          
***| show cdp neighb detail [15]                      
***| show interface status [15]                       
***| terminal length 0 [15]                           
***| show version [15]                                
***| show run [15]                                    
***| show ip interface brief [15]                     
***| copy system:/running-config tftp://192.168.0.16/ 

       [15]

***| [1/3] cisco_telnet_2-lb testbb0lb01 192.168.0.58:23 
***| copy running-config tftp 192.168.0.16 testbb0lb01-confg [15]
***| copy log boot.log tftp 192.168.0.16 testbb0lb01/boot.log [15]
***| copy log sys.log  tftp 192.168.0.16 testbb0lb01/sys.log [15] 
***| copy log traplog  tftp 192.168.0.16 testbb0lb01/traplog [15] 
***| terminal length 65535 [15]                                   
***| show version [15]                                            
***| show chassis [15]                                            
***| show virtual-routers [15]                                    
***| show redundant-vips [15]                                     
***| show interface [15]                                          
***| show phy [15]                                                
***| show circuits all [15]                                       
***| show ip route [15]                                           
***| show ip interfaces [15]                                      
***| show service summary [15]                                    
***| show session-redundant all [15]                              
***| show rule-summary [15]                                       
***| show summary [15]                                            
***| show boot-config [15]                                        
***| show run [15]                                                
***| copy script ap-kal-tcp-ports tftp 192.168.0.16 ap-kal-tcp-ports [15]

***| [2/3] cisco_telnet_2-lb testbb0lb02 192.168.0.59:23 
***| copy running-config tftp 192.168.0.16 testbb0lb02-confg [15]
***| copy log boot.log tftp 192.168.0.16 testbb0lb02/boot.log [15]
***| copy log sys.log  tftp 192.168.0.16 testbb0lb02/sys.log [15] 
***| copy log traplog  tftp 192.168.0.16 testbb0lb02/traplog [15] 
***| terminal length 65535 [15]                                   
***| show version [15]                                            
***| show chassis [15]                                            
***| show virtual-routers [15]                                    
***| show redundant-vips [15]                                     
***| show interface [15]                                          
***| show phy [15]                                                
***| show circuits all [15]                                       
***| show ip route [15]                                           
***| show ip interfaces [15]                                      
***| show service summary [15]                                    
***| show session-redundant all [15]                              
***| show rule-summary [15]                                       
***| show summary [15]                                            
***| show boot-config [15]                                        
***| show run [15]                                                
***| copy script ap-kal-tcp-ports tftp 192.168.0.16 ap-kal-tcp-ports [15]

***| [1/2] ftp_recursive_get testvm0sg01 192.168.0.48:23 
Done...                                                  

***| [2/2] ftp_recursive_get testvm0sg02 192.168.0.49:23 
Done...                                                  

***| [1/2] http_file_get testvm0mg01 192.168.0.50:80 
Done...                                              

***| [2/2] http_file_get testvm0mg02 192.168.0.51:80 
Done...                                              

***| [1/2] ssh_en testen0mn01 192.168.0.65:22 

***| show all [10]

***| upload config tftp://192.168.0.16/testen0mn01.cfg [1]

***| [1/3] ssh_sa testen0sa01 192.168.0.69:22 

***| wwn [1]

***| switchshow [1]

***| licenseidshow [1]

***| cfgshow [1]

***| sensorshow [1]

***| chassisshow [1]

***| portcfgshow [1]

***| sfpshow [1]

***| nsshow [1]

***| porterrshow [1]

***| ifmodeshow eth0 [1]

***| supportshow exception fabric network [10]

***| configupload -all -scp 192.168.0.16,root,/tftpboot/testen0sa01.cfg [1]

***| adminman [1]

***| [2/3] ssh_sa testen0sa02 192.168.0.70:22 

***| wwn [1]

***| switchshow [1]

***| licenseidshow [1]

***| cfgshow [1]

***| sensorshow [1]

***| chassisshow [1]

***| portcfgshow [1]

***| sfpshow [1]

***| nsshow [1]

***| porterrshow [1]

***| ifmodeshow eth0 [1]

***| supportshow exception fabric network [10]

***| configupload -all -scp 192.168.0.16,root,/tftpboot/testen0sa02.cfg [1]

***| adminman [1]

***| [1/9] ssh_sw testbb0sw03 192.168.0.55:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

***| [2/9] ssh_sw testbb0sw04 192.168.0.56:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

***| [3/9] ssh_sw testen0sw01 192.168.0.67:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

***| [4/9] ssh_sw testen0sw02 192.168.0.68:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

***| [5/9] ssh_sw testen0sw03 192.168.0.71:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

***| [6/9] ssh_sw testen0sw04 192.168.0.72:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

***| [7/9] ssh_sw testen0sw05 192.168.0.73:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

***| [8/9] ssh_sw testen0sw06 192.168.0.74:22 

***| enable [1]

***| myenapass [1]

***| terminal length 0 [1]

***| show version [1]

***| show run [1]

***| copy system:/running-config tftp://192.168.0.16/

     [1]

All done...
/tmp/config_download-0.1[su]# 
/tmp/config_download-0.1[su]# ls -Rgho /tmp/config
/tmp/config:                                      
total 1.2M                                        
-rw-r--r--  1  37K Jun  1 14:53 testbb0lb01-192.168.0.58.log
-rw-r--r--  1  37K Jun  1 14:53 testbb0lb02-192.168.0.59.log
-rw-r--r--  1  13K Jun  1 14:53 testbb0rt01-192.168.0.57.log
-rw-r--r--  1  58K Jun  1 14:53 testbb0sw01-192.168.0.60.log
-rw-r--r--  1  58K Jun  1 14:53 testbb0sw02-192.168.0.61.log
-rw-r--r--  1  986 Jun  1 14:56 testbb0sw03-192.168.0.55.log
-rw-r--r--  1  986 Jun  1 14:56 testbb0sw04-192.168.0.52.log
-rw-r--r--  1 227K Jun  1 14:54 testen0mn01-192.168.0.65.log
-rw-r--r--  1 266K Jun  1 14:55 testen0sa01-192.168.0.69.log
-rw-r--r--  1 241K Jun  1 14:56 testen0sa02-192.168.0.70.log
-rw-r--r--  1  986 Jun  1 14:56 testen0sw01-192.168.0.67.log
-rw-r--r--  1  986 Jun  1 14:56 testen0sw02-192.168.0.68.log
-rw-r--r--  1  986 Jun  1 14:56 testen0sw03-192.168.0.71.log
-rw-r--r--  1  986 Jun  1 14:57 testen0sw04-192.168.0.72.log
-rw-r--r--  1  986 Jun  1 14:57 testen0sw05-192.168.0.73.log
-rw-r--r--  1  986 Jun  1 14:57 testen0sw06-192.168.0.74.log
-rw-r--r--  1  71K Jun  1 14:53 testvm0mg01-192.168.0.50.ini
-rw-r--r--  1  71K Jun  1 14:53 testvm0mg02-192.168.0.51.ini
drwxr-xr-x  3 4.0K Jun  1 14:53 testvm0sg01                 
drwxr-xr-x  3 4.0K Jun  1 14:53 testvm0sg02                 

/tmp/config/testvm0sg01:
total 12K               
-rw-r--r--  1 2.2K Jun  1 14:53 config.txt
-rw-r--r--  1  161 Jun  1 14:53 sgw.lic.bak
drwxr-xr-x  2 4.0K Jun  1 14:53 syslog     

/tmp/config/testvm0sg01/syslog:
total 7.7M                     
-rw-r--r--  1  18K Jun  1 14:53 config.CF1
-rw-r--r--  1 2.2K Jun  1 14:53 config.txt
-rw-r--r--  1  132 Jun  1 14:53 modcap    
-rw-r--r--  1   76 Jun  1 14:53 platform_version.log
-rw-r--r--  1  491 Jun  1 14:53 restart_disk.log    
-rw-r--r--  1  789 Jun  1 14:53 restart_gct.log     
-rw-r--r--  1 5.6K Jun  1 14:53 restart_ip.log      
-rw-r--r--  1 8.7K Jun  1 14:53 restart_sensor.log  
-rw-r--r--  1  12K Jun  1 14:53 restart_top.log     
-rw-r--r--  1  155 Jun  1 14:53 sgw.lic
-rw-r--r--  1 7.6M Jun  1 14:53 sgw.tgz

/tmp/config/testvm0sg02:
total 12K
-rw-r--r--  1 2.2K Jun  1 14:53 config.txt
-rw-r--r--  1  161 Jun  1 14:53 sgw.lic.bak
drwxr-xr-x  2 4.0K Jun  1 14:53 syslog

/tmp/config/testvm0sg02/syslog:
total 7.7M
-rw-r--r--  1  18K Jun  1 14:53 config.CF1
-rw-r--r--  1 2.2K Jun  1 14:53 config.txt
-rw-r--r--  1  132 Jun  1 14:53 modcap
-rw-r--r--  1   76 Jun  1 14:53 platform_version.log
-rw-r--r--  1  491 Jun  1 14:53 restart_disk.log
-rw-r--r--  1  789 Jun  1 14:53 restart_gct.log
-rw-r--r--  1 5.9K Jun  1 14:53 restart_ip.log
-rw-r--r--  1 8.7K Jun  1 14:53 restart_sensor.log
-rw-r--r--  1  12K Jun  1 14:53 restart_top.log
-rw-r--r--  1  155 Jun  1 14:53 sgw.lic
-rw-r--r--  1 7.6M Jun  1 14:53 sgw.tgz
/tmp/config_download-0.1[su]#
/tmp/config_download-0.1[su]# find /tftpboot/testbb0*
/tftpboot/testbb0lb01
/tftpboot/testbb0lb01/boot.log
/tftpboot/testbb0lb01/sys.log
/tftpboot/testbb0lb01/traplog
/tftpboot/testbb0lb01-confg
/tftpboot/testbb0lb02
/tftpboot/testbb0lb02/boot.log
/tftpboot/testbb0lb02/sys.log
/tftpboot/testbb0lb02/traplog
/tftpboot/testbb0lb02-confg
```


---


# Screenshots, Video

Screenshots and video can be found [here](Screenshots.md).