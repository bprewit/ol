use Test::More;
use Test::Mojo;
use Mojo::JSON;

use FindBin;
require "$FindBin::Bin/../oltest.pl";

my $t = Test::Mojo->new;

$t->get_ok('/businesses/1')
	->status_is(200);

$t->get_ok('/businesses/2')
	->status(200);

done_testing();

