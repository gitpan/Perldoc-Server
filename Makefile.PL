# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'Perldoc-Server';
all_from 'lib/Perldoc/Server.pm';

requires 'Catalyst::Runtime' => '5.71001';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Plugin::Session::Store::File';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Perl::Tidy';
requires 'OpenThought';
requires 'Pod::POM' => '0.23';
requires 'Catalyst::View::TT';
requires 'File::ShareDir';
requires 'File::Slurp';
requires 'File::Monitor';
requires 'HTML::Entities';
requires 'Capture::Tiny';

catalyst;

install_share 'root';
install_script glob('script/*.pl');
install_script 'script/perldoc-server';
auto_install;
WriteAll;
