use Test::More;
use Test::Mojo;
use Mojo::JSON;
use DBI;

$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 2;

my $dbh = DBI->connect("dbi:CSV:", undef, undef, {
		f_dir => ".",
		f_ext => ".csv/r",
		RaiseError => 1,
		PrintError => 1
	}) or die(DBI->errstr());

use FindBin;
require "$FindBin::Bin/../oltest.pl";

my $t = Test::Mojo->new;
foreach my $n (0,999,49999) {
	$db_rec = fetch_rec($n);
	$t->get_ok("/business/$n")
		->status_is(200)
		->json_has('id'   => $db_rec->{id})
		->json_has('uuid' => $db_rec->{uuid})
		->json_has('name' => $db_rec->{name});
}
$t->get_ok("/business/50000")->status_is(404);
done_testing();

sub fetch_rec {
	my $rec_id = shift;
	my $sql = "SELECT id, uuid, name FROM businesses WHERE id = ?";
	my $sth = $dbh->prepare($sql) or die($dbh->errstr());
	my $rv = $sth->execute(0) or die($dbh->errstr());
	print Dumper($rv);
	my $r = $sth->fetchrow_hashref();
	die("couldn't read database") unless($r);
	return($r);
}

