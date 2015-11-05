use common::sense;

use feature qw(say);
use Anki::WebService::Dejizo;

my $dejizo = Anki::WebService::Dejizo->new;
my $counter = 1;

while (<>) {
    chomp;

    my $req = $dejizo->create_search_dic_item_req($_);
    my $res = $dejizo->do_request($req);

    if ($res->decoded_content !~ /<ItemID>(\d+)<\/ItemID>/) {
        say join("\t", $_, 'N/A: Please update manually');
        next;
    }

    my $item_id = $1;
    $req = $dejizo->create_get_dic_item_req($item_id);
    $res = $dejizo->do_request($req);

    if ($res->decoded_content =~ /<div>(.*?)<\/div>/) {
        say join("\t", $_, $1);
    }

    sleep 1 if $counter++ % 20 == 0;
}
