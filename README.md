# auto_indent

Statistical Source Code Formatter

## Usage

1. Collect data

learn.rb reads the specified files and prints the indent summary. Write it to a file.

```bash
% ruby learn.rb ~/PATH_TO_SOME_PROJECT/lib/**/*.rb > LEARNED_DATA
```

2. Indent

format.rb formats the source code by indent summary.

```bash
ruby format.rb LEARNED_DATA SOURCE_CODE > FORMATTED_SOURCE_CODE
```

## Indent summary

indent summary data looks like below.

```
r,s,2
r,d,2
r,},-2
r,r,2
```

This means, when previous line ends with "r" and next line starts from "s", next line should increase indent by 2 spaces.

## Example (Perl)

Looks good.

```bash
% find ~/Plack/lib/ | grep '\.pm$' | xargs ruby learn.rb > examples/learned_plack.txt
% cat examples/fizz_buzz.pl
use strict;
use warnings;

for my $i (1..30) {
if ($i % 15 == 0) {
print "FizzBuzz\n";
} elsif ($i % 3  == 0 ) {
print "Fizz\n";
} elsif ($i % 5 == 0 ) {
print "Buzz\n";
} else {
print "$i\n";
}
}
% ruby format.rb examples/learned_plack.txt examples/fizz_buzz.pl
use strict;
use warnings;

for my $i (1..30) {
    if ($i % 15 == 0) {
        print "FizzBuzz\n";
    } elsif ($i % 3  == 0 ) {
        print "Fizz\n";
    } elsif ($i % 5 == 0 ) {
        print "Buzz\n";
    } else {
        print "$i\n";
    }
}
```

## Example (Ruby)

Looks bad.

```bash
% find ~/co/rubygems.org/app/ | grep '\.rb$' | xargs ruby learn.rb > examples/learned_rubygems_org.txt
% cat examples/fizz_buzz.rb
1.upto(30) { |i|
if i % 15 == 0
puts 'FizBuzz'
elsif i % 3 == 0
puts 'Fizz'
elsif i % 5 == 0
puts 'Buzz'
else
puts i
end
}
% ruby format.rb examples/learned_rubygems_org.txt examples/fizz_buzz.rb
1.upto(30) { |i|
  if i % 15 == 0
  puts 'FizBuzz'
elsif i % 3 == 0
puts 'Fizz'
elsif i % 5 == 0
puts 'Buzz'
else
  puts i
end
}
```