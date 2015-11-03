use common::sense;

use Test::More;
use Test::Pretty;

my $class = 'Anki::WebService::Alc';
use_ok $class;

subtest ua => sub {
    my $c = $class->new;
    isa_ok $c->ua, 'LWP::UserAgent';
};
subtest create_search_req => sub {
    my $req = $class->create_search_req('test');
    isa_ok $req, 'HTTP::Request';
    isa_ok $req->uri, 'URI';
    is $req->uri->host, 'eow.alc.co.jp';
    is $req->uri->path, '/search';
};

done_testing;

__DATA__

