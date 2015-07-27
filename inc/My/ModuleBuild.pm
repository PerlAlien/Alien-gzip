package My::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );
use Capture::Tiny qw( capture );
use File::chdir;

sub alien_check_installed_version
{
  my($self) = @_;
  my($stdout, $stderr, $ret) = capture { system 'gzip', '--version'; $? };
  $ret ? () : $stdout =~ /gzip ([0-9.]+)/i && $1 || "unknown";
}

sub alien_check_built_version
{
  $CWD[-1] =~ /^gzip-(.*)$/ ? $1 : 'unknown';
}

1;
