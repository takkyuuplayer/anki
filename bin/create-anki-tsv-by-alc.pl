use common::sense;

use feature qw(say);
use Anki::WebService::Alc;

my $alc = Anki::WebService::Alc->new;

while (<>) {
    my $res = $alc->do_request($_);
    chomp;

    my $definition = $alc->parse_definition($res);

    if ($definition) {
        my $content = $definition->content;
        $content =~ s/\r|\n//g;
        say join("\t", $_, $content);
    }
    else {
        say join("\t", $_, 'N/A: Please define manually');
    }

    sleep 10;
}
