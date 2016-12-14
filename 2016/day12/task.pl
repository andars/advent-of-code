use 5.016;
use warnings;
use File::Copy;

say '.text';
say 'run:';

my $i = 0;

while (my $line = <>) {
    chomp $line;

    my ($op, $a, $b) = split ' ', $line;

    say "L$i:";

    if ($op eq 'dec') {
        printf("dec %%r%sx\n", $a);
    } elsif ($op eq 'inc') {
        printf("inc %%r%sx\n", $a);
    } elsif ($op eq 'jnz') {
        if ($a =~ /[a-d]/) {
            printf("test %%r%sx, %%r%sx\n", $a, $a);
            printf("jnz L%d\n", $i+$b);
        } else {
            if ($a != 0) {
                printf("jmp L%d\n", $i+$b);
            }
        }
    } elsif ($op eq 'cpy') {
        my $arg = $a =~ /[a-d]/ ? '%%r%sx' : '$%s';
        printf("mov $arg, %%r%sx\n", $a, $b);
    }
    $i++;
}
say "L$i:";
say 'ret';
STDOUT->flush();
copy('footer.s', \*STDOUT);
