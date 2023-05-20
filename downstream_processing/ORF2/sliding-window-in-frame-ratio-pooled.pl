#perl sliding-window-in-frame-ratio-pooled.pl 4-forward-inv-rmv-filename.txt 36
#mmv "a-4-*-countsum-final-inv-rmv.txt" "5-#1-sliding-window-in-frame-ratio-inv-rmv-36.txt"


open (INPUTFILELIST, "<", $ARGV[0]);


my $windownumber = $ARGV[1];

for (my $i = 10348; $i <= 11940; $i = $i + $windownumber) {
	if ((11940 - $i) < $windownumber) {
		push(@windows, "$i-11940")
		#print "$i-11940\n";
	} else {
		$newi = $i + ($windownumber-1);
		push(@windows, "$i-$newi")
		#print "$i-$newi\n";
	}
}


#foreach (@windows) {
#	print "$_\n";
#}



while (my $inputfile = <INPUTFILELIST>) {
	chomp ($inputfile);
	open (INFILE, "<", $inputfile);
	open (OUTFILE, ">", "a-".$inputfile);
	my $reg2off = 0;
	my $subregoff = 0;
	my $substart = 0;
	my $subend = 0;

	my %goodcountmap = ();
	my %badcountmap = ();
	
	while (my $line = <INFILE>) {
		chomp($line);
		($start_c1, $end_c2, $count_c3) = split /\t/, $line;
		if (($start_c1 >= 10348)&&($end_c2 <= 11940)) {
			$reg2off = $start_c1 - 10348;
			$subregoff = $reg2off % $windownumber ;
			$substart = $start_c1 - $subregoff;
			$subend = $substart + ($windownumber-1);
			$substartend = join ("-", $substart, $subend);
			#print "$substartend\n";
			# 11940-10348=1592
			if ((($start_c1 - 1) % 3) == 0) {
				if (exists($goodcountmap{$substartend})) {
					$goodcountmap{$substartend} = $goodcountmap{$substartend} + 1;
				} else {
					$goodcountmap{$substartend} = 1;
				}
			} else {
				if (exists($badcountmap{$substartend})) {
					$badcountmap{$substartend} = $badcountmap{$substartend} + 1;
				} else {
					$badcountmap{$substartend} = 1;
				}
			}
		}
	}
	
	
	#foreach $key (sort { $a <=> $b } (keys %goodcountmap)) {
	#	print "$key\n";
	#}
	
	
	
	
	print "$inputfile\n";
	foreach $window (@windows) {
		if (exists($goodcountmap{$window})) {
			$totalcount = $goodcountmap{$window} + $badcountmap{$window};
			$goodcountratio = $goodcountmap{$window}/$totalcount;
			print "$window\t$goodcountratio\n";
			print OUTFILE "$window\t$goodcountratio\n";
		} else {
			print "$window\t0\n";
			print OUTFILE "$window\t0\n";
		}
	}
	print "\n";
	
	
		
		



	close INFILE;
	#close OUTFILE;
}

close INPUTFILELIST;
