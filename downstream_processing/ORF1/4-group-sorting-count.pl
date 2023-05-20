open (INPUTFILELIST, "<", $ARGV[0]);




# while loop that reads into INFILE
while (my $inputfile = <INPUTFILELIST>) {
	chomp($inputfile);
	#print "$inputfile\n";
	open (INFILE, "<", $inputfile);
	open (OUTFILE, ">", "sorted-count".$inputfile);
	
	my %countmap = ();
	while (my $line = <INFILE>) {
		chomp($line);
		#print "$line\n";
		($chr_c1, $start_c2, $end_c3, $count_c4, $escore_c5) = split /\t/, $line;
		$countmap_key = join "\t", $start_c2, $end_c3, $escore_c5;
		$countmap{$countmap_key} = $count_c4;
	}
		
	foreach $loopvariablecountmapkey (reverse sort { $countmap{$a} <=> $countmap{$b} } keys (%countmap)) {
	print "$loopvariablecountmapkey\t$countmap{$loopvariablecountmapkey}\n";
	print OUTFILE "$loopvariablecountmapkey\t$countmap{$loopvariablecountmapkey}\n";}
	close INFILE;
	close OUTFILE;
}

close INPUTFILELIST;