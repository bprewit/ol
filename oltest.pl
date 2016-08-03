#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::JSON;
use Mojo::Parameters;
use DBI;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

use Data::Dumper;
$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 1;

my $dbh = undef;
helper db => sub {
	unless($dbh) {
		$dbh = DBI->connect("dbi:CSV:", undef, undef, {
				f_dir => ".", 
				f_ext => ".csv/r", 
				RaiseError => 1, 
				PrintError => 1}
		) or die(DBI->errstr());
	}
	return($dbh);
};

get '/business/:id' => sub {
	my $self = shift;
	my $id = $self->stash('id');
	my $sql = "SELECT * FROM businesses WHERE id = ?";
	my $sth = $self->db->prepare($sql);
	my $rv = $sth->execute($id);
	my $biz = $sth->fetchrow_hashref();
	if(defined($biz)) {
		return($self->render(json => $biz));
	}
	else {
		return($self->render(json => $biz, status => 404));
	}
};

get '/businesses' => sub {
	my $self = shift;
	my $sql = "SELECT * FROM businesses ORDER BY id"; 
	my $sth = $self->db->prepare($sql);
	my $rv = $sth->execute();
	my $list = $sth->fetchall_arrayref({});
	return($self->render(json => $list));
};

get '/businesses/:page' => sub {
	my $self = shift;
	my $page = $self->stash('page') || 1;
	my $page_len = $self->param('page_length') || 50;
	my $start = (($page - 1) * $page_len);
	my $sql = "SELECT * FROM businesses ORDER BY id LIMIT $start, $page_len";
	my $sth = $self->db->prepare($sql);
	my $rv = $sth->execute();
	my $list = $sth->fetchall_arrayref({});
	return($self->render(json => $list));
};


app->start;
