package Dancer2::Logger::PSGI;

use Moo;
our $VERSION = 'v0.0.1'; # VERSION
# ABSTRACT: PSGI logger for Dancer2

with 'Dancer2::Core::Role::Logger';

sub log {
    my ( $self, $level, $message ) = @_;

    my $request = $self->request;
    if ( $request->{env}{'psgix.logger'} ) {
        $request->{env}{'psgix.logger'}->(
            {   level   => $level,
                message => $self->format_message($level => $message),
            }
        );
    }
    return;
}

1;

__END__

=head1 NAME

Dancer2::Logger::PSGI - PSGI Log handler for Dancer2

=head1 SYNOPSIS

In your Dancer's config file:
    logger: PSGI

In your application

    log("error", "this is a error");


=head1 DESCRIPTION

This class is an interface between your Dancer's application and B<psgix.logger>. 
Messages will be logged in whatever logger you decided to use in your L<Plack> handler. If no logger is defined, nothing will be logged.

=head1 CONFIGURATION

The setting C<logger> should be set to C<PSGI> in order to use this logging
engine in a Dancer2 application.

There is no additional setting available with this engine.

=head1 METHODS

=method log

Writes the log message to your defined logger.

=head1 AUTHOR
 
Dinis Rebolo
 
=head1 COPYRIGHT AND LICENSE
 
This software is copyright (c) 2016 by Dinis Rebolo <drebolo AT cpan DOT com>.
It is released under the terms of the B<MIT (X11) License> and may be modified
and/or redistributed under the same or any compatible license.
