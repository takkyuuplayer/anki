package Anki::WebService::Alc;
use common::sense;
use Moo;

use constant BASE_URL => 'https://eow.alc.co.jp/search';
use Mojo::UserAgent;
use URI;

has ua => (
    is      => 'ro',
    default => sub {
        my $ua = Mojo::UserAgent->new;
        $ua->proxy->http('socks://proxy:9050')->https('socks://proxy:9050');
        $ua;
    },
);

sub create_search_uri {
    my ($class, $word) = @_;

    my $uri = URI->new(BASE_URL);
    $uri->query_form({ q => $word, });
    $uri;
}

sub do_request {
    my ($self, $word) = @_;

    my $uri = $self->create_search_uri($word);

    my $tx = $self->ua->build_tx(GET => $uri->as_string);
    $tx = $self->ua->start($tx);
    $tx->result;
}

sub parse_definition {
    my ($class, $res) = @_;

    $res->dom('#resultsList > ul > li > div')->first;
}

1;

