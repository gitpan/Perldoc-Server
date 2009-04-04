package Perldoc::Server;

use strict;
use warnings;
use 5.010;

use Catalyst::Runtime '5.70';
use Sys::Hostname;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/
                ConfigLoader
                Session
                Session::State::Cookie
                Session::Store::File
                Static::Simple/;
our $VERSION = '0.04';

# Configure the application.
#
# Note that settings in perldoc_server.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

my $host = (split('\.',hostname))[0];

__PACKAGE__->config( name             => 'Perldoc::Server',
                     version          => $VERSION,
                     host             => $host, 
                     perl             => $^X,
                     perl_version     => sprintf("%vd",$^V),
                     search_path      => \@INC,
                     'View::TT'       => { INCLUDE_PATH => __PACKAGE__->path_to('root','templates')},
                     'View::Pod2HTML' => { INCLUDE_PATH => __PACKAGE__->path_to('root','templates')},
                    );

# Set default view to TT
__PACKAGE__->config->{default_view} = 'TT';

# Configure default session expiry time
__PACKAGE__->config->{'session'} = {
    expires => 30*24*60*60  # 30 days
};

# Start the application
__PACKAGE__->setup();


=head1 NAME

Perldoc::Server - local Perl documentation server

=head1 SYNOPSIS

 perldoc-server [options]
 
 Options:
 --perl /path/to/perl   Show documentation for this Perl installation
 --port 1234            Set server port number
 --help                 Display help

=head1 DESCRIPTION

Perldoc::Server is a Catalyst application to serve local Perl documentation
in the same style as L<http://perldoc.perl.org>.

In addition to keeping the same look and feel of L<http://perldoc.perl.org>,
Perldoc::Server offer the following features:

=over

=item * View source of any installed module

=item * Improved syntax highlighting

=over

=item * Line numbering

=item * C<use> and C<require> statements linked to modules

=back

=item * Sidebar shows links to your 10 most viewed documentation pages

=back

=head1 CONFIGURATION

By default, Perldoc::Server will show documentation for the Perl installation
used to run the server.

However, it is also possible to serve documentation for a different Perl
installation using the C<--perl> command-line option, e.g.

 perldoc-server --perl /usr/bin/perl

=head1 SEE ALSO

L<http://perldoc.perl.org>

L<http://perl.jonallen.info/projects/perldoc>

Penny's Arcade Open Source - L<http://www.pennysarcade.co.uk/opensource>

=head1 AUTHOR

Jon Allen (JJ) <jj@jonallen.info>

Perldoc::Server was developed at the 2009 QA Hackathon L<http://qa-hackathon.org>
supported by Birmingham Perl Mongers L<http://birmingham.pm.org>

=head1 COPYRIGHT and LICENSE

Copyright (C) 2009 Penny's Arcade Limited - L<http://www.pennysarcade.co.uk>

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
