#!/usr/bin/perl -I/s/ec2/lib
#
# delete oldest quantity of snapshots that will permit new snapshots
# of all filesystems to come under the amazon 500 limit (reduced
# to 50 due to costs)
# 
# XXX logger instead of print... logger util to email?
#
###

use warnings;
use strict;
use Data::Dumper;
use Date::Manip;
use Time::Format;
require ec2;

my $count;
my $delta;
my $i;
my $out;
my $snapshots;
my %s;
my @oldest;

print "preparing to retire old snapshots...\n";

$count = ec2::getvolumes();
$snapshots = ec2::getsnapshots();
$delta = ($#{$snapshots} + 1) + ($#{$count} + 1) - 50;
#$delta = ($#{$snapshots} + 1) - ($#{$count} + 1);

print "found ", $#{$count} + 1, " volumes to backup...\n";
print "found ", $#{$snapshots} + 1, " current snapshots...\n";
print "need to delete $delta snapshots...\n";

for($i = 0; $i <= $#{$snapshots}; $i++) {
  $s{$snapshots->[$i][1]} = Date::Manip::UnixDate($snapshots->[$i][4], '%s');
}

@oldest = sort { $s{$a} <=> $s{$b} } keys %s;

for($i = 0; $i <= ($delta - 1); $i++) {
  print "retiring snapshot ($i) $oldest[$i], from ";
  print Time::Format::time_format('yyyy/mm/dd hh:mm:ss', $s{$oldest[$i]});
  print " ($s{$oldest[$i]})...\n";
  $out = ec2::deletesnapshot($oldest[$i]);
  print "output: $out";
}
