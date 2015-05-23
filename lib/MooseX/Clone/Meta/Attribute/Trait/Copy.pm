package MooseX::Clone::Meta::Attribute::Trait::Copy;
# ABSTRACT: Simple copying of arrays and hashes for MooseX::Clone

our $VERSION = '0.07';

use Moose::Role;
use Carp qw(croak);
use namespace::autoclean;

with qw(MooseX::Clone::Meta::Attribute::Trait::Clone::Base);

sub Moose::Meta::Attribute::Custom::Trait::Copy::register_implementation { __PACKAGE__ }

sub clone_value {
    my ( $self, $target, $proto, %args ) = @_;

    if (exists $args{init_arg}) {
        return $self->set_value( $target, $args{init_arg} );
    }

    return unless $self->has_value($proto);

    my $clone = $self->_copy_ref($self->get_value($proto));

    $self->set_value( $target, $clone );
}

sub _copy_ref {
    my ( $self, $value ) = @_;

    if ( not ref $value ) {
        return $value;
    } elsif ( ref $value eq 'ARRAY' ) {
        return [@$value];
    } elsif ( ref $value eq 'HASH' ) {
        return {%$value};
    } else {
        croak "The Copy trait is for arrays and hashes. Use the Clone trait for objects";
    }
}

__PACKAGE__

__END__

=pod

=head1 SYNOPSIS

    has foo => (
        isa => "ArrayRef",
        traits => [qw(Copy)],
    );

=head1 DESCRIPTION

Unlike the C<Clone> trait, which does deep copying of almost anything, this
trait will only do one additional level of copying of arrays and hashes.

This is both simpler and faster when you don't need a real deep copy of the
entire structure, and probably more correct.

=cut
