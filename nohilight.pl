use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
	authors		=> "Paul Traylor",
	name		=> "nohilight",
	description	=> "Do not hilight messages from a list of users",
	license		=> '',
	url			=> 'http://github.com/kfdm/irssi-nohilight',
	contact		=> 'http://github.com/kfdm/irssi-nohilight/issues'
);

sub remove_hilight {
	my ($dest, $text, $stripped) = @_;
	if ($dest->{level} & MSGLEVEL_HILIGHT) {
		my @nicks = map(quotemeta, split(/[, ]/, Irssi::settings_get_str('nohilight_nicks')));
		foreach my $nick (@nicks) {
			if ($stripped =~ /<.?$nick>/) {
				my $window = $dest->{window};
				$text =~ s/%/%%/g;
				$window->print($text, MSGLEVEL_PUBLIC);
				Irssi::signal_stop();
				return;
			}
		}
	}
}

Irssi::signal_add_first('print text', 'remove_hilight');
Irssi::settings_add_str($IRSSI{'name'}, 'nohilight_nicks', '');
Irssi::print('%G>>%n '.$IRSSI{name}.' '.$VERSION.' loaded');
