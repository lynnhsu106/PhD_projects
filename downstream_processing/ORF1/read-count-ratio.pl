

open (INPUTFILELIST, "<", $ARGV[0]);



my %inframeintervalmap = ();
# key = intervals; value = in frame lines

my %totalintervalmap = ();
# key = intervals; value = total lines

$max = $ARGV[1];
$intervalnum = $ARGV[2];



for (my $i = 0; $i < $max; $i = $i + $intervalnum) {
	$inframeintervalmap{$i} = 0;
	$totalintervalmap{$i} = 0;
}

#foreach $inframekeyvar (sort { $a <=> $b } (keys %inframeintervalmap)) {
#	print "$inframekeyvar\n";
#}

#foreach $totalkeyvar (sort { $a <=> $b } (keys %totalintervalmap)) {
#	#print "$totalkeyvar\n";
#}


#for (my $i = 0; $i < 1001; $i = $i + 50) {
#	push(@intervals, $i)
#}

#foreach (@intervals) {
#	print "$_\n";
#}


while (my $inputfile = <INPUTFILELIST>) {
	chomp ($inputfile);
	open (INFILE, "<", $inputfile);
	($dum1, $seratime2, $round3, $ID4, $dum5, $dum6, $dum7, $dum8) = split /-/, $inputfile;
	$outfilename = "8-$seratime2-$round3-$ID4-in-frame-read-count-ratio.txt";
	open (OUTFILE, ">", $outfilename);

	#key = total lines in interval; value = in frame reads in interval

	while (my $line = <INFILE>) {
		chomp($line);
		($start_c1, $end_c2, $count_c3) = split /\t/, $line;
		if (($start_c1 >= 4995)&&($start_c1 < 10364)&&($end_c2 <= 11940)&&(($start_c1 % 3)==0)) {
			$inframekey = $count_c3 - ($count_c3 % $intervalnum);
			$inframeintervalmap{$inframekey} = $inframeintervalmap{$inframekey} + 1;
		} elsif (($start_c1 >= 10348)&&($start_c1 < 11940)&&($end_c2 <= 12578)&&((($start_c1 - 1) % 3)==0)) { 
			$inframekey = $count_c3 - ($count_c3 % $intervalnum);
			$inframeintervalmap{$inframekey} = $inframeintervalmap{$inframekey} + 1;
		} elsif (($start_c1 >= 11940)&&($end_c2 > 11940)&&($end_c2 <= 12578)&&(($start_c1 % 3)==0)) {
			$inframekey = $count_c3 - ($count_c3 % $intervalnum);
			$inframeintervalmap{$inframekey} = $inframeintervalmap{$inframekey} + 1;
		} else {
		}
		$totalkey = $count_c3 - ($count_c3 % $intervalnum);
		$totalintervalmap{$totalkey} = $totalintervalmap{$totalkey} + 1;
	}
	
	
	#foreach $key (sort { $a <=> $b } (keys %goodcountmap)) {
	#	print "$key\n";
	#}
	

	print "$inputfile\n";
	foreach $inframekeyvar (sort { $a <=> $b } (keys %inframeintervalmap)) {
		if (($inframeintervalmap{$inframekeyvar} > 0)&&($totalintervalmap{$inframekeyvar} > 0)&&($inframekeyvar < $max)) {
			$countratiolines = ($inframeintervalmap{$inframekeyvar} / $totalintervalmap{$inframekeyvar});
			print "$inframeintervalmap{$inframekeyvar}\t$totalintervalmap{$inframekeyvar}\t$inframekeyvar\t$countratiolines\n";
			print OUTFILE "$inframekeyvar\t$countratiolines\n";
		} else {
		}
	}
	

	close INFILE;
	close OUTFILE;
}

close INPUTFILELIST;




