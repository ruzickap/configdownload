#!/usr/bin/perl

#Specify extra modules directory
use FindBin;
use Config;
if ( -d "$FindBin::Bin/$Config{\"installsitearch\"}" ) {
  BEGIN { push (@INC,"$FindBin::Bin/$Config{\"installsitearch\"}") }
}

if ( -d "$FindBin::Bin/$Config{\"installsitelib\"}" ) {
  BEGIN { push (@INC,"$FindBin::Bin/$Config{\"installsitelib\"}") }
}

use Net::SSH::Expect;
use Net::Telnet::Cisco;
use Net::FTP::Recursive;
use HTTP::Lite;
use XML::Simple;
use Cwd;
use Getopt::Long;
use Data::Dumper;

#Default variables
$default_username="anonymous";
$default_password="";
$destination_directory=".";
$my_output="***|";

$default_cisco_telnet_timeout=$default_cisco_telnet_login_timeout=15;
$default_cisco_telnet_prompt='(?m:^\s*[\w.-]+\s?(?:\(config[^\)]*\))?\s?[\$#>]\s?(?:\(enable\))?\s*$)';
$default_cisco_telnet_enable_password="enable";
$default_ssh_timeout=2;
$default_ssh_options='-v -x';
$default_ssh_login_prompt='.*';
$default_ssh_password_prompt='[Pp]assword.*?:|[Pp]assphrase.*?:';
$default_ssh_prompt='.*';

$default_ftp_timeout=10;
$default_http_file_get="/goform/gwcfg.ini";
$default_remote_directory=".";

#set 1 to enable debugging...
$debug=0;
GetOptions ('d|debug' => \$debug,
            'destination=s' => \$destination_directory);

if ($#ARGV != 0) { print "
config_download.pl is a Perl script used for getting/downloading configurations from various devices.

Currently following protocols are supported: 
Cisco telnet, SSH, HTTP file get, FTP recursive copy

Please see example XML file in sample directory to find more information how to create it.

config_download.pl [--debug] [--destination=/my_path/]

Options:
    -d, --[no]debug             enable debug mode, output from commands will be displayed
    --destination=<file>        save all files to specified directory

Example:

$0 my_config_file.xml --debug --destination=/tmp

"; exit }


#Get data from XML file
$hosts = XMLin($ARGV[0], ForceArray => [qw(commands commands_before commands_after)]);

#Show imported XML structure from file 
if ($debug) { print Dumper $hosts; }

#Get sections from hash (/cisco_telnet/, /ssh/, /ftp_recursive_get/, /http_file_get/)
foreach $section (sort keys %{$hosts}) {
  $count=0; 
  #Get hostnames/IPs from section
  foreach $hostname (sort keys %{$hosts->{$section}}) {
    #Skip after/before commands
    if (($hostname eq "commands_after") or ($hostname eq "commands_before")) { next; }
    $count++;
    $host_h=\$hosts->{$section}->{$hostname};

    #Fill variables from XML file
    if (exists($$host_h->{"host"})) {
      $host=$$host_h->{"host"};
    } else { die "$my_output Host (ip/hostname) is not specified in your XML!\n" }
    if (exists($$host_h->{"port"})) {
      $port=$$host_h->{"port"};
    } elsif ($section =~ /cisco_telnet/) { $port=23; }
        elsif ($section =~ /ssh/) { $port=22; }
          elsif ($section =~ /http_file_get/) { $port=80; }
            elsif ($section =~ /ftp_recursive_get/) { $port=21; }
              else { die "$my_output Can't determine default port for your section: \"$section\" and host: \"$host\"\n" }
    if (exists($$host_h->{"username"})) {
      $username=$$host_h->{"username"};
    } else {
        $username=$default_username;
      }
    if (exists($$host_h->{"password"})) {
      $password=$$host_h->{"password"};
    } else {
        $password=$default_password;
      }
    if (exists($$host_h->{"timeout"})) {
      $timeout=$$host_h->{"timeout"};
    } elsif ($section =~ /cisco_telnet/) {
        $timeout=$default_cisco_telnet_timeout;
      } elsif ($section =~ /ssh/) {
          $timeout=$default_ssh_timeout;
        } elsif ($section =~ /ftp_recursive_get/) {
            $timeout=$default_ftp_timeout;
          }
    if (exists($$host_h->{"output_file"})) {
      $output_file=$$host_h->{"output_file"};
    } else {
        $output_file="$destination_directory/$hostname-$host.log";
      }
    if (exists($$host_h->{"prompt"})) {
      $prompt=$$host_h->{"prompt"};
    } elsif ($section =~ /cisco_telnet/) {
        $login_prompt=$prompt=$default_cisco_telnet_prompt;
      } elsif ($section =~ /ssh/) {
          $login_prompt=$prompt=$default_ssh_prompt;
        } 
    if (exists($$host_h->{"login_prompt"})) {
      $login_prompt=$$host_h->{"login_prompt"};
    } elsif (not defined($login_prompt)) {
        if ($section =~ /cisco_telnet/) {
          $login_prompt=$default_cisco_telnet_prompt;
        } elsif ($section =~ /ssh/) {
            $login_prompt=$default_ssh_login_prompt;
          }
      }
    if (exists($$host_h->{"login_timeout"})) {
      $login_timeout=$$host_h->{"login_timeout"};
    } else {
        $login_timeout=$default_cisco_telnet_login_timeout;
      } 
    if (exists($$host_h->{"enable_password"})) {
      $enable_password=$$host_h->{"enable_password"};
    } else {
        $enable_password=$default_cisco_telnet_enable_password;
      }
    if (exists($$host_h->{"password_prompt"})) {
      $password_prompt=$$host_h->{"password_prompt"};
    } else {
        $password_prompt=$default_ssh_password_prompt;
      }
    if (exists($$host_h->{"ssh_options"})) {
      $ssh_options=$$host_h->{"ssh_options"};
    } else {
        $ssh_options=$default_ssh_options;
      }
    if (exists($$host_h->{"remote_directory"})) {
      $remote_directory=$$host_h->{"remote_directory"};
    } else {
        $remote_directory=$default_remote_directory;
      }
    if (exists($$host_h->{"local_directory"})) {
      $local_directory=$$host_h->{"local_directory"};
    } else {
        $local_directory=$destination_directory;
      }
    if (exists($$host_h->{"get_file"})) {
      $get_file=$$host_h->{"get_file"};
    } else {
        $get_file=$default_http_file_get;
      }

    print "\n$my_output [$count/" . (scalar keys %{$hosts->{$section}}) . "] $section $hostname $host:$port \n";

#
# Cisco section
#
    if ($section =~ /cisco_telnet/) {
      my $session = Net::Telnet::Cisco->new(
        Host => $host,
        Timeout => $timeout,
        Input_log => $output_file,
        Prompt => "/$prompt/",
      );

      $session->login(
        "Name" => $username, 
        "Password" => $password,
        "Prompt" => "/$login_prompt/",
        "Timeout" => $login_timeout,
      ) or die "$my_output $session->errmsg";

      #Command loop
      foreach $command (@{$hosts->{$section}->{"commands_before"}},@{$$host_h->{"commands"}},@{$hosts->{$section}->{"commands_after"}}) {
      #Enable section
        if ($command =~ /^en.*/) {
          print "$my_output $command [$timeout]\n";
          if (not $session->enable($enable_password)) {
            warn "$my_output Can't enable: " . $session->errmsg;
          } else { next; }
        }
        #Disable (is anybody using that?)
        if ($command =~ /^disa.*/) { 
          print "$my_output $command [$timeout]\n";
          if (not $session->disable) {
            warn "$my_output Can't disable: " . $session->errmsg;
          } else { next; }
        }
        #Get timeout from command section (if exists) or use default
        if (exists($command->{"timeout"})) {
          $timeout=$command->{"timeout"};
          $command=$command->{"content"};
        } else { $timeout=$default_cisco_telnet_timeout; }
        #Command execution
        print "$my_output $command [$timeout]\n";
        if ($debug) {
          print $session->cmd(String => $command, Timeout => $timeout);
        } else { 
            $session->cmd(String => $command, Timeout => $timeout);
          }
      }
      $session->close;
    }

#
# SSH section
#
    if ($section =~ /ssh/) {
      my $ssh = Net::SSH::Expect->new (
        host => $host,
        password => $password,
        user => $username,
        timeout => $timeout,
        log_file => $output_file,
        raw_pty => 1,
      );

      my $login_output = $ssh->login();
      if ($debug) {
         print $login_output;
      }

      #Check login prompt after successful login
      if ($login_output !~ /$login_prompt/) {
        die "$my_output $login_output\n$my_output I can't log in \"$timeout\" seconds I didn't got \'$login_prompt\' response!\n";
      }

      #Command loop
      foreach $command_h (@{$hosts->{$section}->{"commands_before"}},@{$$host_h->{"commands"}},@{$hosts->{$section}->{"commands_after"}}) {
        #Set timeout or prompt if exists in command section or use default value
        if ((exists($command_h->{"timeout"})) or (exists($command_h->{"prompt"}))) {
          #command_h is hash like this one { 'timeout' => '1', 'content' => 'my_command...' },
          $command=$command_h->{"content"};
          if (exists($command_h->{"timeout"})) {
            $timeout=$command_h->{"timeout"};
          } else { 
              $timeout=$default_ssh_timeout;
            }
          if (exists($command_h->{"prompt"})) {
            $prompt=$command_h->{"prompt"};
          } else { 
              $prompt=$default_ssh_prompt;
            }
        } else {
            #command_h is "string" here
            $command=$command_h;
            $timeout=$default_ssh_timeout;
            $prompt=$default_ssh_prompt;
          }

        #Command execution
        print "\n$my_output $command [$timeout]\n";
        $ssh_output=$ssh->exec($command,$timeout);
        if ($debug) {
          print $ssh_output;
        }
        #Check prompt after command execution
        if ($ssh_output !~ /$prompt/) {
          die "$my_output I can't see \'$prompt\' in \"$timeout\" seconds!\n"
        }
      }
      $ssh->read_all();
      $ssh->close();
    }

#
# HTTP get section
#

    if ($section =~ /http_file_get/) {
      $http = new HTTP::Lite;
      $req = $http->request("http://$host:$port$get_file") or die "$my_output Unable to get document: $!";
      if ($req ne "200") { 
        die "$my_output Request failed ($req): ".$http->status_message();
      }
      open(FILE, ">" . $output_file) or die "$my_output Can't write to file: $output_file\n";
      print FILE $http->body();
      close(FILE);
      print "$my_output Done...\n";
    }

#
# Recursive FTP get section
#
    if ($section =~ /ftp_recursive_get/) {
      $ftp = Net::FTP::Recursive->new($host, Debug => $debug, Timeout => $timeout) or die "$my_output Can't connect to $host: $@";
      $ftp->login($username,$password) or die "$my_output Can't login ", $ftp->message;
      if (not -d $local_directory) { 
        if (not mkdir($local_directory)) { 
          die "$my_output Can't create directory: $local_directory\n";
        }
      }
      $my_dir=getcwd;
      chdir($local_directory) || die "$my_output Can't change directory to: $local_directory\n";
      $ftp->cwd($remote_directory);
      $ftp->rget();
      chdir($my_dir) || die "$my_output Can't change directory back to: $my_dir\n";
      $ftp->quit;
      print "$my_output Done...\n";
    }
  }
}
print "\n$my_output All done...\n";
