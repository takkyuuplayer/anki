use common::sense;

use feature qw(say);
use Anki::WebService::Alc;

my $alc = Anki::WebService::Alc->new;

while (<>) {
    my $res = $alc->do_request($_);
    chomp;
    say join("\t", $_, $alc->parse_definition($res)->all_text)
}
