# README file

```
*** Introduction to config_download ***                          

config_download.pl is Perl script allowing downloading configs from various
devices using standard protocols. It can run various commands on the devices
and log their outputs. Currently ssh, cisco-telnet, ftp and http methods are
supported.                                                                  

The script is written in Perl and depends on few external modules:

Net-Telnet-Cisco -> Net::Telnet 
Net-SSH-Expect -> Expect -> IO::Pty
Net-FTP-Recursive                  
HTTP::Lite                         

Before you will run the script please ensure you have these modules installed
in your system.                                                              


*** Installation ***

Install all possible modules to your system using your package manager:

 aptitude install libnet-telnet-cisco-perl libexpect-perl libxml-simple-perl

Install/build non-common modules from CPAN:

   perl -MCPAN -e 'install IO::Tty'
   perl -MCPAN -e 'install Net::Telnet::Cisco'
   perl -MCPAN -e 'install Net::SSH::Expect'  
   perl -MCPAN -e 'install Net::FTP::Recursive'
   perl -MCPAN -e 'install HTTP::Lite'         
   perl -MCPAN -e 'install XML::Simple'        

or you can use compile it yourselves:
(You need to have gcc installed if you want to compile IO-Tty)

   DESTINATION_DIRECTORY="/tmp/config_download"
   mkdir -pv $DESTINATION_DIRECTORY/sources    
   wget http://search.cpan.org/CPAN/authors/id/R/RG/RGIERSIG/IO-Tty-1.08.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/J/JR/JROGERS/Net-Telnet-3.03.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/J/JO/JOSHUA/Net-Telnet-Cisco-1.10.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/R/RG/RGIERSIG/Expect-1.21.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources        
   wget http://search.cpan.org/CPAN/authors/id/B/BN/BNEGRAO/Net-SSH-Expect-1.09.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources 
   wget http://search.cpan.org/CPAN/authors/id/J/JD/JDLEE/Net-FTP-Recursive-2.04.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/R/RH/RHOOPER/HTTP-Lite-2.1.6.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources     
   wget http://search.cpan.org/CPAN/authors/id/G/GR/GRANTM/XML-Simple-2.18.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources      
   for DIR in $DESTINATION_DIRECTORY/sources/*; do cd $DIR && perl Makefile.PL PREFIX=$DESTINATION_DIRECTORY`perl -MConfig -e 'print $Config{"siteprefix"}'` && make && make install && cd ..; done                                                                                                                       
   wget http://configdownload.googlecode.com/svn/trunk/config_download.pl --directory-prefix=$DESTINATION_DIRECTORY && chmod a+x $DESTINATION_DIRECTORY/config_download.pl                                                                                                                                                


*** Basic configuration ***
The configuration is based on input XML file added as parameter to
config_download.pl script.                                        

The script has following parameters:

config_download.pl [--debug] [--destination=/my_path/]

Options:
    -d, --[no]debug             enable debug mode, output from commands will be displayed
    --destination=<file>        save all files to specified directory                    


Here is the description of main section of XML input file:

The configuration XML file is splitted into few sections:
<configuration>                                          
  <cisco_telnet>...</cisco_telnet>           - for interacting with cisco
                                               devices accessed through telnet
  <ssh>...</ssh>                             - for ssh interacted devices     
  <http_file_get>...</http_file_get>         - to get http configuration from 
                                               device                         
  <ftp_recursive_get>...</ftp_recursive_get> - to recursively transfer ftp    
                                               directory from remote device   
</configuration>                                                              

Every section contains additional parameters like login names, passwords,
files etc.                                                               

There can be multiple sections, but should always contains names "ssh",
"cisco_telnet"... For example <cisco_telnet_1> or <ssh_2>.             

Every section can contain <commands_before> and <commands_after> where can be
written commands to be executed. These commands are executed in all hosts    
defined for the hosts and before/after commands specified in hosts sections. 


** Cisco telnet interaction **
Here is a example of XML section for Cisco:

<configuration>
  <cisco_telnet>
      <!-- Command executed before for all defines hosts before their own "command section" -->
      <commands_before>enable</commands_before>                                                
      <!-- Command executed after for all defines hosts before their own "command section" --> 
      <commands_after>show version</commands_after>                                            
    <test0rt01 host="192.168.244.57" port="23" username="admin" password="12345" enable_password="123456" login_timeout="1" output_file="./test0rt01-192.168.244.57.log" login_prompt='(?m:^Please enter your selection:\s*$)'>                                                                                           
      <commands>show ip route 192.168.0.1</commands>                                                                                                         
    </test0rt01>                                                                                                                                             
    <test0rt02 host="192.168.244.58" port="23" username="admin" password="12345" enable_password="123456" login_timeout="1" output_file="./test0rt01-192.168.244.58.log" login_prompt='(?m:^Please enter your selection:\s*$)'>                                                                                           
      <commands timeout=2>x</commands>                                                                                                                       
      <commands>show ip route 192.168.0.1</commands>                                                                                                         
    </test0rt02>                                                                                                                                             
  </cisco_telnet>                                                                                                                                            
</configuration>                                                                                                                                             

You can see 2 hosts defined in this section: test0rt01, test0rt02. For
every host you can specify connection details, timeouts, log and prompt.

host,username,password,enable_password
login_timout - specifies how much time can take login procedure
               (default 15 seconds)                            
login_prompt - defines how should look prompt after successful login 
               (by default it's cisco standard prompt)               
output_file  - defines output log where the whole interaction is stored
               (default it's <hostname>-<ip>.log)                      
port         - port (default: 23)                                      
prompt       - how looks default prompt after executing the commands   
               (by default it's cisco standard prompt)                 

Every hostname (test0rt02) section can contain commands which will be
executed and you can also specify timeout for them:                  
<commands timeout=1>show ip route 192.168.0.1</commands>             

timeout      - specifies how long can command run before it goes back to
               "prompt". If command run longer than the "timeout value" you
               will get error.                                             


** SSH interaction **

Example of SSH:

<configuration>
  <ssh>        
    <commands_after>show run</commands_after>
    <switch04 host="192.168.244.56" port="22" username="admin" password="test" timeout="1" output_file="./switch04-192.168.244.52.log" ssh_options="-v" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' password_prompt='[Pp]assword.*?:|[Pp]assphrase.*?:' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>                                                                                                   
      <commands timeout="1" prompt='\s*[Pp]assword:\s*'>enable</commands>                                                                                    
      <commands>my_enable_password</commands>                                                                                                                
      <commands>terminal length 0</commands>                                                                                                                 
      <commands>show version</commands>                                                                                                                      
  </ssh>                                                                                                                                                     
</configuration>                                                                                                                                             

Like in previous example, you have to specify host, port, username and
password. You can also set few parameters like timeout, log_file, ssh_options,
login_prompot, password_prompt and prompt.                                    

login_prompt    - shows how the login prompt should look like in regular
                  expression after successful login (by default: .*)    
output_file     - defines output log where the whole interaction is stored
                  (default it's <hostname>-<ip>.log)                      
password_prompt - like login_promt set how password prompt looks like     
                  (by default: [Pp]assword.*?:|[Pp]assphrase.*?:)         
prompt          - is a default prompt used by device (by default: .*)     
ssh_options     - contain list of parameters used when script is calling ssh
                  command (none by default)                                 
timeout         - default timeout for all commands, if the expected prompt is
                  not there before timeout value you will get error          

Every command section can specify "timeout" and "prompt":
<commands prompt=".*password:\s*" timeout="1" >configupload -all -scp 192.168.0.16,root,/tftpboot/test0sa01.cfg</commands>


** HTTP file get **

HTTP file get method can download defined file from HTTP server.

</configuration>
  <http_file_get>
    <test0mg02 host="192.168.0.51" port="80" get_file="/goform/gwcfg.ini" output_file="test0mg02-192.168.0.51.ini" />
    <test0mg01 host="192.168.0.50" get_file="/goform/gwcfg.ini" output_file="test0mg01-192.168.0.50.ini" />
  </http_file_get>
</configuration>

You can specify:

get_file    - specify file which should be downloaded from the server
host        - IP/hostname of the server
output_file - destination file where the downloaded file should be stored
port        - service port (80 by default)


** FTP recursive download **

If you need to recursively download files/directories from the FTP server use
this method.

<configuration>
  <ftp_recursive_get>
    <test0sg02 host="192.168.0.49" username="siuftp" password="siuftp" remote_directory='.' local_directory='./test0sg02' />
    <test0sg01 host="192.168.0.48" username="siuftp" password="siuftp" local_directory='./test0sg01' />
  </ftp_recursive_get>
</configuration>

host             - the ip/hostname of the FTP server
local_directory  - local directory where the data will be stored (default: ".")
                   [the directory is created if does not exist]
password         - password (default: <empty>)
remote_directory - remote directory on the FTP server (default: ".")
username         - login (default: anonymous)


*** Author, version, license information ***
License: GNU General Public License Version 3 (see LICENSE file)
Platforms: All (Linux, NT, BSD, Solaris and other *NIX's, BeOS, OS/2...)
Author: Petr Ruzicka <petr.ruzicka@gmail.com>
Latest version: http://configdownload.googlecode.com
(svn checkout http://configdownload.googlecode.com/svn/trunk/ configdownload-read-only)
```