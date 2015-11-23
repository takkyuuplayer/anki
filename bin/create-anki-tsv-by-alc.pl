use common::sense;

use Anki::WebService::Alc;

my $alc = Anki::WebService::Alc->new;

while (<>) {
    chomp;
    my $res;
    for (my $i = 0; $i < 3; $i++) {
        last if $res = $alc->do_request($_);
    }

    unless ($res) {
        warn join("\t", $_, 'N/A: Please define manually');
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
        warn join("\t", $_, 'N/A: Please define manually');
        say join("\t", $_, 'N/A: Please define manually');
    }
}
