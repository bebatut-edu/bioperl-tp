#!/usr/bin/perl -w

=head1 NAME

    extract_sequences.pl - Scripts to extract sequences for practicals

=head1 SYNOPSIS

    template_script.pl -h

=head1 DESCRIPTION

    Original datasets are too big to be easily manageable by students.
    So sequences are randomly extracted in different sequence files

=head1 AUTHORS

    Berenice Batut: berenice.batut@udamail.fr

=cut

# ------------------------------------------------------------------------------
# Imports
# ------------------------------------------------------------------------------

use strict;
use File::stat;
use Bio::Seq;
use Bio::SeqIO;
use Data::Dumper;

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------
my $data_download = 0;
if ( $data_download ){
    system "wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR029/SRR029695/SRR029695.fastq.gz";
    system "mv SRR029695.fastq.gz ../data/";
    system "gunzip ../data/SRR029695.fastq.gz";
}

my $filepath = "../data/SRR029695.fastq";

my $groups_number = 14;
my @group_sequence_files = ();
for (my $i = 0; $i < 14; $i++){
    push(@group_sequence_files, Bio::SeqIO->new(
        -file => '>../data/'.$i.'.fastq', 
        -format => 'fastq' ));
}

my $seqio_obj = Bio::SeqIO->new(-file => $filepath, -format => "fastq" );
my $random_nb;
my $seq_obj;
while ($seq_obj = $seqio_obj->next_seq()){
    $random_nb = int(rand($groups_number));
    $group_sequence_files[$random_nb]->write_seq($seq_obj);
}