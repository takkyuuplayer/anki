package Anki::WebService::Dejizo;
use common::sense;
use Moo;

use LWP::UserAgent;
use URI;
use HTTP::Request::Common qw(GET);

use constant BASE_URL   => 'http://public.dejizo.jp/NetDicV09.asmx';
use constant END_POINTS => {
    search => '/SearchDicItemLite',
    get    => '/GetDicItemLite',
};

has ua => (
    is      => 'ro',
    default => sub {
        my $ua = LWP::UserAgent->new;
    },
);

sub create_search_dic_item_req {
    my ($class, $word) = @_;

    my $uri = URI->new(BASE_URL . END_POINTS->{search});
    $uri->query_form(
        {   Dic       => 'EJdict',
            Word      => $word,
            Scope     => 'HEADWORD',
            Match     => 'EXACT',
            Merge     => 'AND',
            Prof      => 'XHTML',
            PageSize  => 1,
            PageIndex => 0,
        }
    );
    GET $uri;
}

sub create_get_dic_item_req {
    my ($class, $item_id) = @_;

    my $uri = URI->new(BASE_URL . END_POINTS->{get});
    $uri->query_form(
        {   Dic  => 'EJdict',
            Item => $item_id,
            Loc => 'N/A',
            Prof => 'XHTML',
        }
    );
    GET $uri;
}

sub do_request {
    my ($self, $req) = @_;

    $self->ua->request($req);
}

1;

