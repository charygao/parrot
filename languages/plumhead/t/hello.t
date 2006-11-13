# $Id$

=head1 NAME

plumhead/t/hello.t - tests for Plumhead

=head1 DESCRIPTION

Hello World test.

=cut

# pragmata
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib", "$FindBin::Bin/../../../lib";

use Parrot::Config (); 
use Parrot::Test;
use Test::More     tests => 4;


language_output_is( 'Plumhead', <<'END_CODE', <<'END_EXPECTED', 'hello' );
<?php
echo "Hello, World!\n";
?>
END_CODE
Hello, World!
END_EXPECTED


language_output_is( 'Plumhead', <<'END_CODE', <<'END_EXPECTED', 'only alphanumic' );
<?php echo "Hello World"; ?>
<?php echo "\n"; ?>
END_CODE
Hello World
END_EXPECTED


language_output_is( 'Plumhead', <<'END_CODE', <<'END_EXPECTED', 'hello with some HTML' );
<html>
<head>
  <title>Servus</title>
</head>
<body>
<pre>
<?php
echo "Hello, World!\n";
?>
</pre>
</body>
</html>
END_CODE
<html>
<head>
  <title>Servus</title>
</head>
<body>
<pre>
Hello, World!
</pre>
</body>
</html>
END_EXPECTED


language_output_is( 'Plumhead', <<'END_CODE', <<'END_EXPECTED', 'hello in a var' );
<?php
$h = "Hello, World!\n";
echo $h;
?>
END_CODE
Hello, World!
END_EXPECTED

