use Test::More;
use Test::Mojo;

use FindBin;
require "$FindBin::Bin/../oltest.pl";

my $t = Test::Mojo->new;
$t->get_ok('/')->status_is(404);
$t->get_ok('/xyzzy')->status_is(404);
done_testing();
