package Javersion;
use strict;
use warnings;
use utf8;
use feature 'say';
use Data::Dumper;

sub new {
    my $class = shift;
    my $version = shift;
    bless {
        pattern => '^JDK([1-9][0-9]*?)u([1-9][0-9]*?)$',
        version => $version,
    }, $class;
}

sub is_valid {
    my ($self, $version) = @_;
    return 0 unless $version;
    return 1 if $version =~ /$self->{pattern}/;
    return 0;
}

sub get_family_number {
    my $self = shift;
    die("error!") unless $self->{version} =~ /$self->{pattern}/;
    return $1;
}

sub get_update_number {
    my $self = shift;
    die("error!") unless $self->{version} =~ /$self->{pattern}/;
    return $2;
}

1;
