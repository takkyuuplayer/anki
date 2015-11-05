use common::sense;

use Test::More;
use Test::Pretty;
use Encode qw(encode_utf8);

my $class = 'Anki::WebService::Dejizo';
use_ok $class;

subtest ua => sub {
    my $c = $class->new;
    isa_ok $c->ua, 'LWP::UserAgent';
};
subtest create_search_dic_item_req => sub {
    my $req = $class->create_search_dic_item_req('test');
    isa_ok $req, 'HTTP::Request';
    is $req->uri->host, 'public.dejizo.jp';
    is $req->uri->path, '/NetDicV09.asmx/SearchDicItemLite';

    my %params = $req->uri->query_form;

    is_deeply \%params, {
        Dic       => 'EJdict',
        Word      => 'test',
        Scope     => 'HEADWORD',
        Match     => 'EXACT',
        Merge     => 'AND',
        Prof      => 'XHTML',
        PageSize  => 1,
        PageIndex => 0,

    };

};
subtest create_get_dic_item_req => sub {
    my $req = $class->create_get_dic_item_req('test');
    isa_ok $req, 'HTTP::Request';
    is $req->uri->host, 'public.dejizo.jp';
    is $req->uri->path, '/NetDicV09.asmx/GetDicItemLite';

    my %params = $req->uri->query_form;

    is_deeply \%params,
        {
        Dic  => 'EJdict',
        Item => 'test',
        Loc  => 'N/A',
        Prof => 'XHTML',
        };

};

subtest do_request => sub {
    SKIP: {
        skip 'should be mocked', 2;

        my $c = $class->new;

        subtest create_search_dic_item_req => sub {
            my $res = $c->do_request($c->create_search_dic_item_req('test'));
            isa_ok $res, 'HTTP::Response';
            warn $res->decoded_content;
        };
        subtest create_search_dic_item_req => sub {
            my $res = $c->do_request($c->create_get_dic_item_req('041386'));
            isa_ok $res, 'HTTP::Response';
            warn $res->decoded_content;
        };
    }
};

done_testing;

__DATA__

