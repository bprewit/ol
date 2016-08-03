oltest: Perl REST API for OwnLocal Business Data

Endpoints implemented:
	/business/{id}				returns JSON data for business id {id}.
	/businesses				returns list of all businesses in database.
	/businesses/{page}			returns paginated list of businesses (default length 50).
	/businesses/{page}/?{page_len=N}	returns paginated list of businesses, page length N.
							
INSTALLATION:	
1) Install mojolicious API framework
		Debian-ish systems: apt-get install libmojolicious-perl
		Others: see https://github.com/kraih/mojo/wiki/Installation

2) Install perl CSV module(s):
		cpan Bundle::CSV

3) Create CSV file to be used for database, named 'businesses.csv'

RUNNING:
	a) ./oltest get [-v] <endpoint>
	b) morbo -l "http://*:8080" (use curl or browser for requests)
	c) ./oltest test [-v]



