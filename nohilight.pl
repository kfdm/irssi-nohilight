use Irssi;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
        authors => "Paul Traylor",
        contact => "",
        name => "nohilight",
        description => "Do not hilight messages from a list of users",
        license => "",
        changed => ""
);

sub remove_hilight {
	my ($dest, $text, $stripped) = @_;
	if ($dest->{level} & MSGLEVEL_HILIGHT) {
		my @nicks = split(/,/, Irssi::settings_get_str('nohilight_nicks'));
		foreach my $nick (@nicks) {
			if ($stripped =~ "$nick") {
				my $window = $dest->{window};
				$window->print($text, MSGLEVEL_PUBLIC);
				Irssi::signal_stop();
			}
		}
	}
}

Irssi::signal_add_first('print text', 'remove_hilight');
Irssi::settings_add_str($IRSSI{'name'}, 'nohilight_nicks', '');