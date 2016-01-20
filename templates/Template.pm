#!/usr/bin/perl -w

package Template;

=head1 NAME

    Template.pm - Template for class

=head1 SYNOPSIS

    use Template;
    my $template_object = Template->new("Berenice");
    my $prenom = $template_object->get_prenom();

=head1 DESCRIPTION

    Blabla blabla

=head1 AUTHORS

    Berenice Batut: berenice.batut@udamail.fr

=cut

# ------------------------------------------------------------------------------
# Imports
# ------------------------------------------------------------------------------

use strict;


# ------------------------------------------------------------------------------
# Constructor
# ------------------------------------------------------------------------------

=head1 CONSTRUCTOR Template->new()

    The new class method constructs a new Template object

=head2 Inputs

    A string

=head2 Outputs

    New Template object

=cut

sub new {
    my ($class, $prenom) = @_;
    my $this = {};
    bless ($this, $class);
    $this->{PRENOM} = $prenom;
    return $this;
}

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

=head1 FUNCTION Template->get_prenom()

    This function return PRENOM from a Template object

=head2 Inputs

    None

=head2 Outputs

    PRENOM properties of the Template object

=cut

sub get_prenom{
    my ($this) = @_;
    return $this->{PRENOM};
}

1;
