#comparing the ratio of in frame reads within a range in enriched and naive libraries to check the validity of epitopes
#perl range-in-frame-check.pl 3-D14SERA-R2-141-countsum-final-inv-rmv.txt 3-naive-countsum-final-inv-rmv.txt 5670 6000



open (ENRICHED, "<", $ARGV[0]);
open (NAIVE, "<", $ARGV[1]);


$enriched_inframecount = 0;
$enriched_allcount = 0;



#my $range1 = (($ARGV[2] - 1)*3) + 4995;
#print "$range1\n";
#my $range2 = (($ARGV[3])*3 + 4995) - 1;
#print "$range2\n";


my $range1 = $ARGV[2];
my $range2 = $ARGV[3];




while (my $eline = <ENRICHED>) {
	chomp($eline);
	#print "$eline\n";
	($start_c1, $end_c2, $count_c3) = split /\t/, $eline;		
	if (($start_c1 > $range1)&&($start_c1 < 10364)&&($end_c2 < $range2)) {
		$enriched_allcount++;
		if (($start_c1 % 3) == 0) {
			$enriched_inframecount++;
		}
	}
}

$naive_inframecount = 0;
$naive_allcount = 0;



while (my $nline = <NAIVE>) {
	chomp($nline);
	#print "$nline\n";
	($start_c1, $end_c2, $count_c3) = split /\t/, $nline;	
	if (($start_c1 > $range1)&&($start_c1 < 10364)&&($end_c2 < $range2)) {
		$naive_allcount++;
		if (($start_c1 % 3) == 0) {
			$naive_inframecount++;
		}
	}
}

print "\n";
print "enriched: $enriched_inframecount\t$enriched_allcount\n";
print "naive: $naive_inframecount\t$naive_allcount\n";
print "\n";


$enriched_inframeratio = ($enriched_inframecount/$enriched_allcount);
$naive_inframeratio = ($naive_inframecount/$naive_allcount);
$diff = ($enriched_inframeratio - $naive_inframeratio);

if ($enriched_inframeratio > $naive_inframeratio) {
	print "YAS\n";
	print "\n";
	print "enriched: $enriched_inframeratio\n";
	print "naive: $naive_inframeratio\n";
	print "$diff\n";
} else {
	print "NO\n";
	print "\n";
	print "enriched: $enriched_inframeratio\n";
	print "naive: $naive_inframeratio\n";
	print "$diff\n";
}
	
print "\n";


close ENRICHED;
close NAIVE;




