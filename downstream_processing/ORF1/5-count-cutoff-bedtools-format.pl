#ls | grep inv-rmv > 4-filenamelist.txt
#perl 5-count-cutoff-bedtools-format.pl 4-filenamelist.txt 5

#Program to set a cutoff by count number and output as format for bedtools

open (INPUTFILELIST, "<", $ARGV[0]);


# while loop that reads into INFILE
while (my $inputfile = <INPUTFILELIST>) {
	chomp($inputfile);
	#print "$inputfile\n";
	open (INFILE, "<", $inputfile);
	($filename, $txt) = split /\./, $inputfile;
	#print "$filename\n";
	($dum1, $seratime2, $round3, $ID4, $dum5, $dum6, $dum7, $dum8, $dum9) = split /-/, $filename;
	$outfilename = "5-$seratime2-$round3-$ID4-in-frame-count-cutoff.txt";
	open (OUTFILE, ">", $outfilename);
	while (my $line = <INFILE>) {
		chomp($line);
		#print "$line\n";
		$countcutoff = $ARGV[1];
		($start_c1, $end_c2, $escore, $count_c3) = split /\t/, $line;	
		if ($count_c3 > $countcutoff) {
			if (($start_c1 >= 4995)&&(($start_c1 % 3) == 0)) { #&&($end_c2 <= 10364)) { 
			##ORF1: 4995-10364
				print OUTFILE "chr1\t$start_c1\t$end_c2\n";
			} elsif (($start_c1 >= 10348)&&((($start_c1 - 1) % 3) == 0)) { #&&($end_c2 <= 11940)) { 
			##ORF2: 10348-11940
				print OUTFILE "chr1\t$start_c1\t$end_c2\n";
			} elsif (($start_c1 >= 11940)&&(($start_c1 % 3) == 0)) { #&&($end_c2 <= 12578)) {
			##ORF3: 11940-12578			
				print OUTFILE "chr1\t$start_c1\t$end_c2\n";
			} 				
		} else {
		}
	}
	

	close INFILE;
	close OUTFILE;
}


close INPUTFILELIST;
close RATIO;



