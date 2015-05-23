#!/usr/bin/perl

package MooseX::Clone::Meta::Attribute::Trait::Clone::Base;

our $VERSION = '0.06';

use Moose::Role;

use namespace::clean -except => [qw(meta)];

requires "clone_value";

__PACKAGE__

__END__
