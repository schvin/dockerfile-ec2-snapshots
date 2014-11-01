#!/bin/csh

/s/ec2/bin/snap-retire.pl

foreach vol (`$EC2_HOME/bin/ec2-describe-volumes | awk '/^VOLUME/ { print $2 }' `)
  echo "snapshotting $vol..."
  $EC2_HOME/bin/ec2-create-snapshot $vol
  echo "done snapshotting $vol..."
end
