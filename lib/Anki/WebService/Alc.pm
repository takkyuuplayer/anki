package Anki::WebService::Alc;
use common::sense;
use Moo;

use LWP::UserAgent;
use URI;
use HTTP::Request::Common qw(GET);
use constant BASE_URL => 'http://eow.alc.co.jp/search';

sub create_search_req {
    my ($class, $word) = @_;

    my $uri = URI->new(BASE_URL);
    $uri->query_form({ q => $word, });
    GET $uri;
}

1;

