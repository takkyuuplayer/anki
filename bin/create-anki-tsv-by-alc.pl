use common::sense;

use feature qw(say);
use Anki::WebService::Alc;

my $alc = Anki::WebService::Alc->new;

while (<>) {
    my $res = $alc->do_request($_);
    chomp;

    unless ($res) {
        say join("\t", $_, 'N/A: Please define manually');
        next;
    }
    my $definition = $alc->parse_definition($res);

    if ($definition) {
        my $content = $definition->content;
        $content =~ s/\r|\n//g;
        $content =~ s|<span class="kana">.+?</span>||g;
        say join("\t", $_, $content);
    }
    else {
        say join("\t", $_, 'N/A: Please define manually');
    }

    sleep 30;
}
