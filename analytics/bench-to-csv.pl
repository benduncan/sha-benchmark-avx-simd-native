#!/usr/bin/perl

my $size, $lang, $chk, $time, $instance, $file;

$file = $ARGV[0];
$instance = $ARGV[1];

open(F, $file) || die "Cannot open file: $!";

while(<F>) {

    $line = $_;

    chomp($line);

    #print $line;

    if($line =~/^(\d+\w)\.bin\s?>\s?(.*)/) {

        $size = $1;
        $lang = $2;
        $chk=1;

    }

    if($chk && $line =~ /real\s?(.*)/) {

        my $time = $1;
        print "$instance, $size, $lang, $time\n";

    }

}

close(F);
