#! /usr/bin/perl -w

# usage: translate.pl -f osm_file_name.osm -t translate_file

use strict;
use File::Basename;
use Getopt::Long qw(:config auto_abbrev);

my $in_filename = '';
my $translate_file = '';

if (!GetOptions ('filename=s' => \$in_filename, 'translate-file=s'  => \$translate_file))
 {
  print "usage: translate.pl --filename osm_file_name.osm --translate-file translate_file\n";
  print "usage: translate.pl -f osm_file_name.osm -t translate_file\n";
  exit(1);
 }

if ($in_filename eq '')
 {
  die "Error: no input file given\n";
 }
if ($translate_file eq '')
 {
  die "Error: no translate file given\n";
 }

require $translate_file;

my $out_basename = basename($in_filename,".osm");
my $out_filename = sprintf("%s_translated.osm", $out_basename);

open INFILE, $in_filename or die $!;
open OUTFILE, ">", $out_filename or die $!;

my $line = '';

while (<INFILE>)
 {
  $line = &translate($_);
  print OUTFILE $line;
#  print $line;
 }

close OUTFILE;
close INFILE;

