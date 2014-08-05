# Coffeefuck
This is a [brainfuck](http://esolangs.org/wiki/Brainfuck) interpreter written in Coffeescript.

Johan Asplund
## Usage
```
$ coffee main.coffee -h
Usage: main.coffee <code> [-i <inputs>...]

-h --help     Show this.
-v --version  Shows the version.
-i --inputs   Specify inputs for each "," in order.
              Number of inputs must match the number of ",".
```

Note that `<code>` is a *string* containing the actual code.

## Examples

### Hello, world!

```
$ coffee main.coffee "++++++++[<+++++++++>-]<.>+++++[<++++++>-]<-.+++++++..+++.>>+++++++++++[<++++>-]<.------------.<++++++++.--------.+++.------.--------.>+."
Hello, world!
```

### Cat program (only 1 character though)

```
$ coffee main.coffee ",." -i c
c
```

```
$ coffee main.coffee ",.,.,." -i c a t
cat
```

### Sum of the first n digits
```
$ coffee main.coffee ",>>++++++[<++++>-]<[<-->-]<[[>+>+<<-]>>[<<+>>-]<-]+<[>+[<]>-[>]<<]>->>+++++++++++[<+++>-]<[<+>-]<." -i 7
=
```

This program outputs a character whose ASCII value subtracted by 33 is the actual result of the program. In this case `=` has ASCII value 61, which gives that the actualy output of the program is 28 as expected.
