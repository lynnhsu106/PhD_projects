#ls | grep in-frame-count-cutoff > 5-in-frame-count-cutoff-filenamelist.txt
#perl 6-bedtools-genomecov-command-pooled.pl 5-in-frame-count-cutoff-filenamelist.txt

#Program to do genomecov on files in the inputfilelist


open (INPUTFILELIST, "<", $ARGV[0]);





# while loop that reads into INFILE
while (my $inputfile = <INPUTFILELIST>) {
	chomp($inputfile);
	open (INFILE, "<", $inputfile);
	($filename, $txt) = split /\./, $inputfile;
	#print "$filename\n";
	($dum1, $seratime2, $round3, $ID4, $dum5, $dum6, $dum7, $dum8) = split /-/, $filename;
	$outfilename = "6-$seratime2-$round3-$ID4-in-frame-count-cutoff-genomecov-analyzed.txt";
	open (OUTFILE, ">", $outfilename);
	system("bedtools genomecov -i $inputfile -g GI1-genome.txt -d > $outfilename");
	close INFILE;
	close OUTFILE;
}


close INPUTFILELIST;





