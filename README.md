dockerfile-ec2-snapshots

Simply enumerate your volumes, snapshot each, and keep last x snapshots (deleting older ones).

To pull:

  `docker pull schvin/ec2-snapshots`

To run:

  `docker run -e TOTAL_SNAPSHOTS=25 -e AWS_ACCESS_KEY=xxxx -e AWS_SECRET_KEY=xxxx -it schvin/ec2-snapshots`

To do:

* add mail notifications of output?
* make a smarter calculation of how many to keep depending on how many volumes you have
