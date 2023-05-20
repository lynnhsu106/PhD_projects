#!/usr/bin/perl
# This program reads the  GI-1-naive-##-1N file and gets the coordinates and then searches them against the ms4205-2N files that have been selected for the appropriate bot strand barcode#
# and produces the matching coordinates
#use strict;
#use warnings;
use Time::HiRes qw( time );

#open INFILE, "<GI-1-naive-$npos-1N";
open (INFILE, "<", $ARGV[0]);
#INFILE is the 1N output file from program 2 (search program) and has the positions along with the coordinates

open (COORDSEQFILE, "<", $ARGV[1]);
#COORDSEQFILE is the 2N output file from program 0 (linking coordinates with

# my @npos = (1..12781);
#open COUNTSUM, ">>coord-files/coord-summary";
open (COUNTSUM, ">", $ARGV[2]);
# foreach $npos (@npos) {
# my $count = 0;
# my @rec =();
# print "$npos\n\n";

#open OUTFILE, ">coord-files/GI-1-naive-$npos-2N-coord-out";
open (OUTFILE, ">", $ARGV[3]);


my $curr_junc = -1;
my %coord_search;
my $count = 0;
while (<INFILE>) {
	chomp;
	if (/0 seqs/) {
		print "0 seqs\n";
		print OUTFILE "0 seqs";
		goto ENDPOSLOOP;
	}
#	print "$_\n";
	(my $junc, my $dummy, my $coord, my $nid, my $nsq) = split (/ /);
#	print "$junc\n";
#	print "$coord\n";
#	print "$nid\n";
#	print "$nsq\n";
	($forbid, $coord2) = split /@/, $coord;
#	print "$coord2\n";
	($d1, $d2, $d3, $d4, $coord3, $coord4, $coord5) = split /:/, $coord2;
	my $coordf = join ":", $coord3, $coord4, $coord5;

	if ($curr_junc == -1) {
		$curr_junc = $junc;
		$coord_search{$coordf} = 1;
	} else {
		if ($junc == $curr_junc) {
			$coord_search{$coordf} = 1; #$coord_search . '|' . $coordf;
		} else {
			$count = 0;
			my $start_time = time();
		#	print "$coord_search\n";
			while (<COORDSEQFILE>) {
				(my $coord0, my $dummy0, my $nsq0) = split (/ /);
				($d10, $d20, $d30, $d40, $coord30, $coord40, $coord50) = split /:/,$coord0;
				my $coordf0 = join ":", $coord30, $coord40, $coord50;

				#if ($coordf0 =~ m/($coord_search)/) {
				if (exists($coord_search{$coordf0})) {
					$count++;
				#	print "$curr_junc\n";
				#	print "$count\n";
				#	print "$_\n";
					print OUTFILE "$curr_junc\t$_\n";

				}
			}
			my $end_time = time();
			my $elapsed_time = $end_time - $start_time;
			print "$curr_junc\t $count \t $elapsed_time\n";
			print COUNTSUM "$curr_junc\t $count\n";
			if ($count == 0) {
				print OUTFILE "$curr_junc 0 seqs\n";
			}
			$curr_junc = $junc;
			#$coord_search = $coordf;
			undef %coord_search = ();
			$coord_search{$coordf} = 1;
			seek COORDSEQFILE, 0, SEEK_SET;
		}
	}
}

close INFILE;
close OUTFILE;
close COORDSEQFILE;
ENDPOSLOOP:
close COUNTSUM;
exit;
#	foreach $c (@rec) {
#	print "$c\n";
#	}

#$seqfile = '/Users/timothypalzkill/Documents/Illum-seq-files/ms4205-2N-GI-1-naive-bot'


