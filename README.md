# Decrypto
Simple MD5 hexidecimal hash decrypter in Perl. The script googles an MD5 hexidecimal hash and attempts to find it on the first page of the search.

###Prerequisites
* Perl >= 5.10
* Install the following modules
    - LWP::UserAgent
    - JSON
    - Mozilla::CA
    - Digest::MD5 (Should come with Perl)
* You can install the modules using CPAN, CPANM or anything else of your choice

###To run
* `$ perl Decrypto.pl <MD5_HEX_HASH>` (Note that the script only accepts one arg)
