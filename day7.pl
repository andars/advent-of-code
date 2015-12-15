use 5.012;
use strict;
use warnings;

my %circuit;

sub is_numeric {
    no warnings;
    my $value = shift;
    return ($value eq $value + 0);
}

while(<>) {
    my @tokens = split;
    if (/AND/) {
        $circuit{$tokens[4]} = ['AND', $tokens[0], $tokens[2]];
    } elsif (/OR/) {
        $circuit{$tokens[4]} = ['OR', $tokens[0], $tokens[2]];
    } elsif (/NOT/) {
        $circuit{$tokens[3]} = ['NOT', $tokens[1]];
    } elsif (/LSHIFT/) {
        $circuit{$tokens[4]} = ['LSHIFT', $tokens[0], $tokens[2]];
    } elsif (/RSHIFT/) {
        $circuit{$tokens[4]} = ['RSHIFT', $tokens[0], $tokens[2]];
    } else {
        if (is_numeric($tokens[0])) {
            $circuit{$tokens[2]} = [int $tokens[0]];
        } else {
            $circuit{$tokens[2]} = ['REF', $tokens[0]];
        }
    }
}

my %ca;

sub cache {
    my $key = shift;
    my $val = shift;
    $ca{$key} = $val;
}

sub cached {
    my $key = shift;
    return exists $ca{$key};
}

sub value {
    my $key = shift;
    #say 'key is ' . $key;
    if (is_numeric($key)) {
        return $key;
    }

    if (cached($key)) {
        return $ca{$key};
    }
    my @el = @{ $circuit{$key} };
#    print 'arr: ';
    #say @el;
    #print 'val: ';
    #say $el[0];

    for ($el[0]) {
        if (/AND/) {
            my $res = value($el[1]) & value($el[2]);
            cache($key, $res);
            return $res;
        } elsif (/OR/) {
            my $res = value($el[1]) | value($el[2]);
            cache($key, $res);
            return $res;
        } elsif (/NOT/) {
            my $res = ~value($el[1]) & 0xffff;
            cache($key, $res);
            return $res;
        } elsif (/LSHIFT/) {
            my $res = value($el[1]) << $el[2];
            cache($key, $res);
            return $res;
        } elsif (/RSHIFT/) {
            my $res = value($el[1]) >> $el[2];
            cache($key, $res);
            return $res;
        } elsif (/REF/) {
            return value($el[1]);
        } else {
            return $el[0];
        }
    }

}

my $val_a = value('a');
print "part 1: value of a: " . $val_a . "\n";

%ca = ();

$circuit{'b'} = [($val_a)];

print "part 2: value of a: " . value('a') . "\n";


