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
;,},{"-4":754,"-8":15,"-15":1,"-2":4,"-9":1,"-12":1,"-19":1}
;,$,{"0":408,"-4":14,"3":2,"-2":1}
;,#,{"0":65}
```

This means, when previous line ends with ";" and next line starts from "}", next line should reduce indent by 4 spaces.

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

## Indent Checker

lint.rb recommends indents by the indent summary. This is useful for finding wrong indents.

```bash
ruby lint.rb --stats LEARNED_DATA SOURCE_CODE
```

Looks good.

```
% ruby lint.rb --stats examples/learned_plack.txt examples/fizz_buzz.pl
examples/fizz_buzz.pl line 5, 0 should 4 by 1.0
  for my $i (1..30) {
- if ($i % 15 == 0) {
+     if ($i % 15 == 0) {

examples/fizz_buzz.pl line 6, 0 should 4 by 1.0
  if ($i % 15 == 0) {
- print "FizzBuzz\n";
+     print "FizzBuzz\n";

examples/fizz_buzz.pl line 7, 0 should -4 by 0.9703989703989704
      print "FizzBuzz\n";
-     } elsif ($i % 3  == 0 ) {
+ } elsif ($i % 3  == 0 ) {

examples/fizz_buzz.pl line 8, 0 should 4 by 1.0
  } elsif ($i % 3  == 0 ) {
- print "Fizz\n";
+     print "Fizz\n";

examples/fizz_buzz.pl line 9, 0 should -4 by 0.9703989703989704
      print "Fizz\n";
-     } elsif ($i % 5 == 0 ) {
+ } elsif ($i % 5 == 0 ) {

examples/fizz_buzz.pl line 10, 0 should 4 by 1.0
  } elsif ($i % 5 == 0 ) {
- print "Buzz\n";
+     print "Buzz\n";

examples/fizz_buzz.pl line 11, 0 should -4 by 0.9703989703989704
      print "Buzz\n";
-     } else {
+ } else {

examples/fizz_buzz.pl line 12, 0 should 4 by 1.0
  } else {
- print "$i\n";
+     print "$i\n";

examples/fizz_buzz.pl line 13, 0 should -4 by 0.9703989703989704
      print "$i\n";
-     }
+ }

examples/fizz_buzz.pl line 14, 0 should -4 by 0.9813084112149533
      }
-     }
+ }
```
