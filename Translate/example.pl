# define your tranlation tags here
#
# the key is the tag from the ogr2osm.py conversion
#
#

%type = (
not_specified => 'building=yes|fixme=check building type',		# this if for blank TYPE values
Bridge => 'bridge=yes|layer=1',
);


# this is your translation subroutine
#
# you need to write this to suit your conversion
#

sub translate
 {
  my $j1 = '';
  my $j2 = '';
  my $j3 = '';
  my $j4 = '';
  my $v1 = '';
  my $t = '';
  my $tags = '';

# remove a tag

  if (m/k="TYPE_DESC"/)
   {
    return '';
   }

# translate a tag to one or more tags

  if (m/k="TYPE"/)
   {
    ($j1,$j2,$j3,$v1,$j4) = split(/"/);

    $v1 =~ s/ /_/g;
    if ($v1 eq '')
     {
      $v1 = 'not_specified';
     }

    my @t = split(/\|/, $type{$v1});
    $tags = '';

    foreach $t (@t)
     {
      my ($k, $v) = split(/=/, $t);
      $tags .= "<tag k=\"$k\" v=\"$v\" />\n";
     }

# add a tag to all translations

    $tags .= "<tag k="source" v="testing" />\n";

    return $tags;
   }
  else
   {
    return $_;
   }
 }

1;

