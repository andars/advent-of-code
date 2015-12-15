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
        $circuit{$tokens[2]} = [$tokens[0]];
    }
}

my %cache;

sub cache {
    my $key = shift;
    my $val = shift;
    if (defined $val) {
        $cache{$key} = $val;
    } else {
        return $cache{$key};
    }
}

sub cached {
    my $key = shift;
    return exists $cache{$key};
}

sub value {
    my $key = shift;

    if (is_numeric($key)) {
        return $key;
    }

    if (cached($key)) {
        return cache($key);
    }
    my @el = @{ $circuit{$key} };

    for ($el[0]) {
        if (/AND/) {
            return cache($key, value($el[1]) & value($el[2]));
        } elsif (/OR/) {
            return cache($key, value($el[1]) | value($el[2]));
        } elsif (/NOT/) {
            return cache($key, ~value($el[1]) & 0xffff);
        } elsif (/LSHIFT/) {
            return cache($key, value($el[1]) << $el[2]);
        } elsif (/RSHIFT/) {
            return cache($key, value($el[1]) >> $el[2]);
        } else {
            return value($el[0]);
        }
    }
}

my $val_a = value('a');
print "part 1: value of a: " . $val_a . "\n";

%cache = ();

$circuit{'b'} = [($val_a)];

print "part 2: value of a: " . value('a') . "\n";
