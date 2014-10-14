package My::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );
use Capture::Tiny qw( capture );
use Config;
use File::Temp qw( tempdir );
use File::chdir;

sub new
{
  my($class, %args) = @_;
  
  $args{alien_name} = 'gzip';
  $args{alien_repository} = {
    protocol => 'http',
    host     => 'ftp.gnu.org',
    location => "/gnu/gzip/",
    pattern  => qr{^gzip-.*\.tar\.gz$},
  };
  
  my $self = $class->SUPER::new(%args);
  
  $self;
}

sub alien_check_installed_version
{
  my($self) = @_;
  my($stdout, $stderr, $ret) = capture { system 'gzip', '--version'; $? };
  return if $ret;
  return $1 if $stdout =~ /gzip ([0-9.]+)/i;
  return 'unknown';
}

sub alien_check_built_version
{
  $CWD[-1] =~ /^gzip-(.*)$/ ? $1 : 'unknown';
}

1;
