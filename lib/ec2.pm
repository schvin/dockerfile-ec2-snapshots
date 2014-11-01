package ec2;

sub getfqdnbyinstance {

  my $fqdn;
  my $instance;

  $instance = shift;

  $fqdn = $instance;

  return($fqdn);

}

sub getvolumes {

  my $cmd;
  my $debug;
  my $out;
  my @volumes;

  $debug = '0';

  $cmd = "$ENV{EC2_HOME}/bin/ec2-describe-volumes | awk '/^VOLUME/ { print $2 }'";
  $out = `$cmd`;

  print $out if $debug;

  @volumes = split(/\n/, $out);

  return(\@volumes);

}

sub getsnapshots {

  my $cmd;
  my $i;
  my $out;
  my @lines;
  my @parts;
  my @snapshots;

  $cmd = "$ENV{EC2_HOME}/bin/ec2-describe-snapshots";
  $out = `$cmd`;

  @lines = split(/\n/, $out);
  for($i = 0; $i <= $#lines; $i++) {
    @parts = split(/\t/, $lines[$i]);
    my @a = @parts;
    push @snapshots, [ @a ];
  }

  return(\@snapshots);

}

sub deletesnapshot {

  my $cmd;
  my $out;
  my $snap;

  $snap = shift;

  $cmd = "$ENV{EC2_HOME}/bin/ec2-delete-snapshot $snap";
  $out = `$cmd`;

  return($out);

}

1;
