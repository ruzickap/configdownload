# Table of Content



# Introduction to config\_download

config\_download.pl is Perl script allowing downloading configs from various
devices using standard protocols. It can run various commands on the devices
and log their outputs. Currently ssh, telnet, cisco-telnet, ftp and http
methods are supported.

The script is written in Perl and depends on few external modules:

  * [Net-Telnet-Cisco](http://search.cpan.org/dist/Net-Telnet-Cisco/) -> [Net::Telnet](http://search.cpan.org/~jrogers/Net-Telnet/)
  * [Net-SSH-Expect](http://search.cpan.org/~bnegrao/Net-SSH-Expect/) -> [Expect](http://search.cpan.org/~rgiersig/Expect/) -> [IO::Pty](http://search.cpan.org/~rgiersig/IO-Tty/)
  * [Net-FTP-Recursive](http://search.cpan.org/~jdlee/Net-FTP-Recursive/)
  * [HTTP::Lite](http://search.cpan.org/~rhooper/HTTP-Lite/)

Before you will run the script please ensure you have these modules installed in your system.

Before you will run the script please ensure you have these modules installed
in your system.


## Installation

Install all possible modules to your system using your package manager:

```
 aptitude install libnet-telnet-cisco-perl libexpect-perl libxml-simple-perl
```


Install/build non-common modules from [CPAN](http://www.cpan.org/):

```
   perl -MCPAN -e 'install IO::Tty'
   perl -MCPAN -e 'install Net::Telnet::Cisco'
   perl -MCPAN -e 'install Net::SSH::Expect'  
   perl -MCPAN -e 'install Net::FTP::Recursive'
   perl -MCPAN -e 'install HTTP::Lite'         
   perl -MCPAN -e 'install XML::Simple'        
```

or you can use compile it yourselves:
(You need to have gcc installed if you want to compile [IO-Tty](http://search.cpan.org/~rgiersig/IO-Tty/))
(you should have libxml-simple-perl installed)

```
   DESTINATION_DIRECTORY="/tmp/config_download"
   mkdir -pv $DESTINATION_DIRECTORY/sources    
   wget http://search.cpan.org/CPAN/authors/id/R/RG/RGIERSIG/IO-Tty-1.08.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/J/JR/JROGERS/Net-Telnet-3.03.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/J/JO/JOSHUA/Net-Telnet-Cisco-1.10.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/R/RG/RGIERSIG/Expect-1.21.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources        
   wget http://search.cpan.org/CPAN/authors/id/B/BN/BNEGRAO/Net-SSH-Expect-1.09.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources 
   wget http://search.cpan.org/CPAN/authors/id/J/JD/JDLEE/Net-FTP-Recursive-2.04.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources
   wget http://search.cpan.org/CPAN/authors/id/R/RH/RHOOPER/HTTP-Lite-2.1.6.tar.gz -O - | tar -xvzf - -C $DESTINATION_DIRECTORY/sources     
   for DIR in $DESTINATION_DIRECTORY/sources/*; do cd $DIR && perl Makefile.PL PREFIX=$DESTINATION_DIRECTORY`perl -MConfig -e 'print $Config{"siteprefix"}'` && make && make install && cd ..; done                                                                                                                       
   wget http://configdownload.googlecode.com/svn/trunk/config_download.pl --directory-prefix=$DESTINATION_DIRECTORY && chmod a+x $DESTINATION_DIRECTORY/config_download.pl
```

## Download

You can download the lastest version here:

http://code.google.com/p/configdownload/downloads/list

You can also use most actual SVN version:

```
svn checkout http://configdownload.googlecode.com/svn/trunk/ configdownload-read-only
```

(Don't forget to download/install required Perl modules otherwise the script will not work)

# Basic configuration
The configuration is based on input XML file added as parameter to config\_download.pl script.


## Command Line Arguments

The script accepts following parameters:

```
config_download.pl [--debug] [--destination=/my_path/] <CONFIG_FILE.XML>
```

Options:
|    -d, --[no](no.md)debug|             enable debug mode, output from commands will be displayed|
|:-------------------------|:---------------------------------------------------------------------|
|    --destination=directory|   save all files to specified directory                              |


## Description of Configuration XML file

Config file should start and end with "configuration" element:

```
<configuration>
</configuration>
```

You will specify the group sections between.

### Group sections

You can specify the groups for devices administration.

Currently supported:

```
<configuration>
  <telnet>...</telnet>                       - simple telnet communication
  <cisco_telnet>...</cisco_telnet>           - for interacting with cisco
                                               devices accessed through telnet
  <ssh>...</ssh>                             - for ssh interacted devices
  <http_file_get>...</http_file_get>         - get http configuration from
                                               device
  <ftp_recursive_get>...</ftp_recursive_get> - recursively transfer ftp
                                               directory from remote device
</configuration>
```

Every group section have to start with key words above. You can append what
ever you want after key word:

```
<configuration>
  <telnet_123>...</telnet_123>
  <ssh_machine1>...</ssh_machine1>
</configuration>
```

Every group section contain additional parameters like login names, passwords,
files etc.

Each section can contain `<commands_before>` and `<commands_after>` where you can
specify commands to be executed before/after "normal" commands. These commands
are executed on all hosts defined for particular section and before/after
commands specified in hosts sections.

```
<configuration>
  <telnet>
      <commands_before>ls -l /</commands_before>
      <commands_before>df -h</commands_before>
      <commands_after>uname -a</commands_after>
    <test host="127.0.0.1" port="23" username="root" password="abcd">
      <commands>uptime</commands>
    </test>
    <test2 host="127.0.0.1" port="23" username="root" password="abcd">
      <commands>hostname</commands>
    </test2>
  </telnet>
</configuration>
```

This example illustrate telnet connection with authentication. Commands are
executed in this order for "test1":

  * ls -l
  * df -h
  * uptime
  * uname -a

The command order for "test2" is:

  * ls -l
  * df -h
  * hostname
  * uname -a

Command sections can also contain timeout and expected prompt parameters:

```
<commands_before timeout="1" prompt='\s*[Pp]assword:\s*'>enable</commands_before>
```

It means, that after command "enable" there should appear "Password prompt"
after one second. Otherwise you will get error.
(I'm using this example for ssh only enabled switches.)

### Host sections

Host sections define what will be executed after successful connection/login.

Every hostname (test0rt02) section can contain commands which will be executed
and you can also specify their timeouts and prompts:

```
<commands timeout=1>show version</commands>
```

This will execute "show version" command which should be completed before 1
sec.


### Telnet interaction
If you want to use simple telnet connection please look at this example:

```
<configuration>
  <telnet>
      <commands_before>ALLIP;</commands_before> <!-- Alarm List PrintReset -->
      <commands_before>STSLP;</commands_before> <!-- Status Signalling Link Print -->
    <sg01 host="127.0.0.1" port="8100" login_timeout="1" timeout="1" output_log="./sg02.log" prompt="&lt;">
    </sg01>
  </telnet>
</configuration>
```


The example above showing access without login by telnet. It just connect to
the port 8100, send two commands and ends. After very command the "<" prompt
needs to be displayed.
(If you want to use login/password please use username="admin" password="12345" values)

  * Possible Host Section Values

|host (mandatory) | IP or hostname of device you are connecting to|
|:----------------|:----------------------------------------------|
|port             | port (default: 23)                            |
|username         | login name                                    |
|password         | password for login                            |
|timeout          | specifies how long can command run before it goes back to|
|                 |  "prompt". If command run longer than the "timeout value" you|
|                 |  will get error                               |
|prompt           | how looks default prompt after executing the commands|
|                 |  (by default it is: `/[\$%#>] $/`)            |
|output\_file      | defines output log where the whole interaction is stored|
|                 |  (default it is hostname-ip.log)              |
|login\_timeout    | specifies how much time can take login procedure|
|                 |  (default 15 seconds)                         |

### Cisco telnet interaction

Here is the Cisco example:

```
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
```

You can see 2 hosts defined in this section: test0rt01, test0rt02. For every
host you can specify "default" connection details described in telnet section
(host, port, username, password, timeout, prompt, output\_file, login\_timeout)
and few more:

|enable\_password  | password used for switching to enable mode|
|:-----------------|:------------------------------------------|
|login\_prompt     | defines how should look prompt after successful login|
|                  |  by default it is cisco standard prompt: (`?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$`)|
|prompt            | by default it is cisco standard prompt    |


### SSH interaction

SSH Example:

```
<configuration>
  <ssh>
    <commands_after>show run</commands_after>
    <switch04 host="192.168.244.56" port="22" username="admin" password="test" timeout="1" output_file="./switch04-192.168.244.52.log" ssh_options="-v" login_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)' password_prompt='[Pp]assword.*?:|[Pp]assphrase.*?:' prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)'>
      <commands timeout="1" prompt='\s*[Pp]assword:\s*'>enable</commands>
      <commands>my_enable_password</commands>
      <commands>terminal length 0</commands>
      <commands>show version</commands>
    </switch04>
  </ssh>
</configuration>
```

Like in previous example, you have to specify host, port, username and
password. You can also set few extra parameters:

|login\_prompt     | shows how the login prompt should look like in regular|
|:-----------------|:------------------------------------------------------|
|                  |  expression after successful login (by default: `.*`) |
|output\_file      | defines output log where the whole interaction is stored|
|                  |  (default it is hostname-ip.log)                      |
|password\_prompt  | like login\_promt set how password prompt looks like  |
|                  |  (by default: `[Pp]assword.*?:|[Pp]assphrase.*?:`)    |
|prompt            | is a default prompt used by device (by default: `.*`) |
|ssh\_options      | contain list of parameters used when script is calling ssh|
|                  |  command (none by default)                            |
|timeout           | default timeout for all commands, if the expected prompt is|
|                  |  not there before timeout value you will get error    |


### HTTP file get

HTTP file get method can download defined file from HTTP server.

```
</configuration>
  <http_file_get>
    <test0mg02 host="192.168.0.51" port="80" get_file="/goform/gwcfg.ini" output_file="test0mg02-192.168.0.51.ini" />
    <test0mg01 host="192.168.0.50" get_file="/goform/gwcfg.ini" output_file="test0mg01-192.168.0.50.ini" />
  </http_file_get>
</configuration>
```

You can specify:

|get\_file         | specify file which should be downloaded from the server|
|:-----------------|:-------------------------------------------------------|
|host              | IP/hostname of the server                              |
|output\_file      | destination file where the downloaded file should be stored|
|port              | service port (80 by default)                           |


### FTP recursive download

If you need to recursively download files/directories from the FTP server use
this method.

```
<configuration>
  <ftp_recursive_get>
    <test0sg02 host="192.168.0.49" username="siuftp" password="siuftp" remote_directory='.' local_directory='./test0sg02' />
    <test0sg01 host="192.168.0.48" username="siuftp" password="siuftp" local_directory='./test0sg01' />
  </ftp_recursive_get>
</configuration>
```

|host             | the ip/hostname of the FTP server|
|:----------------|:---------------------------------|
|local\_directory  | local directory where the data will be stored (default: "`.`")|
|                 |  [directory is created if does not exist](the.md)|
|password         | password (default: `<empty>`)    |
|remote\_directory | remote directory on the FTP server (default: "`.`")|
|username         | login (default: anonymous)       |



# Example XML file and screenshots

Example XML Config file can be found [here](SampleXMLfile.md).

[Screenshots](Screenshots.md)

# Author, version, license information

License: GNU General Public License Version 3 (see LICENSE file)

Platforms: All (Linux, NT, BSD, Solaris and other UNIX's, BeOS, OS/2...)

Author: Petr Ruzicka <petr.ruzicka@gmail.com>

Home page: http://configdownload.googlecode.com/