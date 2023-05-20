open (INFILE, "<", $ARGV[0]);
open (OUTFILE, ">", $ARGV[1]);
# open OUTFILE, ">GI-1-s-R2-257-1N";
while (my $line = <INFILE>) {
	chomp($line);
#	print "$_ \n";
	my $barcode = $ARGV[2];
	if ($line =~ $barcode) {
		$count1++;
		print  "$count1\n";
		print OUTFILE "$count1\n";
#		print "$_ \n";$
		print OUTFILE "$line \n";
#		push(@mid1seq, $_)
		}
	 }
close (OUTFILE);


