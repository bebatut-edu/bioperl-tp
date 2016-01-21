#!/usr/bin/perl -w

=head1 NAME

    template_script.pl - Scripts for BioPerl practicals

=head1 SYNOPSIS

    template_script.pl -h

=head1 DESCRIPTION

    Blabla blabla

=head1 AUTHORS

    Berenice Batut: berenice.batut@udamail.fr

=cut

# ------------------------------------------------------------------------------
# Imports
# ------------------------------------------------------------------------------

use strict;
use Template;

# ------------------------------------------------------------------------------
# Main
# ------------------------------------------------------------------------------

my $template_object = Template->new("Berenice");
my $prenom = $template_object->get_prenom();
hello( $prenom );


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

=head1 FUNCTION hello

    This function prints hello.

=head2 Inputs

    String

=head2 Outputs

    None

=cut

sub hello{
    my ($prenom) = @_;
    print "Bonjour $prenom\n";
}
