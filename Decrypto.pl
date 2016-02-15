#!/usr/bin/perl

use 5.010;
use strict;

my $md5_hash = $ARGV[0];

die "Please enter an MD5 hash" if $md5_hash !~ /^[0-9a-f]{32}$/i;

use LWP::UserAgent;
use JSON;
use Mozilla::CA;
use Digest::MD5 qw( md5_hex );

my $url = "https://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=${md5_hash}";

my $ua = LWP::UserAgent->new( ssl_opts => { verify_hostname => 1 } );
$ua->ssl_opts( SSL_ca_file => Mozilla::CA::SSL_ca_file() );

my $body = $ua->get( $url );
my $json = from_json( $body->decoded_content );

my $decrypt = '';

FINDMD5: 
foreach my $result ( @{ $json->{responseData}->{results} } ) {
	$result->{content} =~ s/&quot;//g;
	for my $word ( split / /, $result->{content} ) {
        $word =~ s/^\s+|\s+$//g;
		if ( $md5_hash eq md5_hex $word ) {
            $decrypt = $word;
            last FINDMD5;
        }
	}
}

die "Hash search unsuccessful" if $decrypt eq '';
say "${md5_hash} : ${decrypt}";
