# Introduction to config\_download.pl script #

config\_download.pl is Perl script allowing downloading configs from various devices using standard protocols. It can run various commands on the devices and log their outputs. Currently ssh, telnet, cisco-telnet, ftp and http methods are supported.

The script is written in Perl and depends on few external modules:

  * [Net-Telnet-Cisco](http://search.cpan.org/dist/Net-Telnet-Cisco/) -> [Net::Telnet](http://search.cpan.org/~jrogers/Net-Telnet/)
  * [Net-SSH-Expect](http://search.cpan.org/~bnegrao/Net-SSH-Expect/) -> [Expect](http://search.cpan.org/~rgiersig/Expect/) -> [IO::Pty](http://search.cpan.org/~rgiersig/IO-Tty/)
  * [Net-FTP-Recursive](http://search.cpan.org/~jdlee/Net-FTP-Recursive/)
  * [HTTP::Lite](http://search.cpan.org/~rhooper/HTTP-Lite/)

Before you will run the script please ensure you have these modules installed in your system.

# News #

  * config\_download.pl (version 0.1) has been released 2009.06.07

# Installation #
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

You can also compile them yourselves:

(You need to have gcc installed if you want to compile [IO-Tty](http://search.cpan.org/~rgiersig/IO-Tty/))

(You should have libxml-simple-perl installed)

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

## Download ##

You can download the recent version here:

http://code.google.com/p/configdownload/downloads/list

You can get latest version from SVN:

```
svn checkout http://configdownload.googlecode.com/svn/trunk/ configdownload-read-only
```

(Don't forget to download/install required Perl modules otherwise the script will not work)

# Documentation #

Please check the [Wiki](HomeOfconfig_download.md) for more information and [examples](SampleXMLfile.md).


# Author, version, license information #

License: [GNU General Public License Version 3](http://www.gnu.org/licenses/gpl-3.0-standalone.html)

Platforms: All (Linux, NT, BSD, Solaris and other UNIX's, BeOS, OS/2...)

Author: Petr Ruzicka <petr.ruzicka@gmail.com>

Latest version: http://configdownload.googlecode.com/