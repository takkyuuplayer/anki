use common::sense;

use Test::More;
use Test::Pretty;
use Encode qw(encode_utf8);

my $class = 'Anki::WebService::Alc';
use_ok $class;

subtest ua => sub {
    my $c = $class->new;
    isa_ok $c->ua, 'Mojo::UserAgent';
    isa_ok $c->ua->proxy, 'Mojo::UserAgent::Proxy';
    is $c->ua->proxy->http,  'socks://127.0.0.1:9050';
    is $c->ua->proxy->https, 'socks://127.0.0.1:9050';
};
subtest create_search_req => sub {
    my $uri = $class->create_search_uri('test');
    isa_ok $uri, 'URI';
    is $uri->host, 'eow.alc.co.jp';
    is $uri->path, '/search';
};
subtest do_request => sub {
    my $requester = $class->new;
    my $res       = $requester->do_request('word');

    isa_ok $res, 'Mojo::Message::Response';
};
subtest parse_definition => sub {
    my $requester = $class->new;
    my $res       = $requester->do_request('word');
    isa_ok $requester->parse_definition($res), 'Mojo::DOM';
};

done_testing;

__DATA__

