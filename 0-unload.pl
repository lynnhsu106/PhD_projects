open (INFILE, "<", $ARGV[0]);
open (OUTFILE, ">", $ARGV[1]);
# open OUTFILE, ">0-SERA-fastq-coord-1N";

while (my $line = <INFILE>) {
	chomp($line);
#	if (/A00202:/) {
        if ($line =~ $ARGV[2]) {
        $count1++;
	print "$count1\n";
#	print "$line  ";
	print OUTFILE "$line ";
	}
	elsif ($line =~ /T/) {
	print "IT'S WORKING\n";
	print OUTFILE "$line\n";
	}
	}
close (OUTFILE);
exit;


