# Zylt Programming Language

**Zylt** is an experimental Lisp/Brainfuck-inspired programming language.

- **Version:** 0.0.1
- **License:** MIT (provided AS-IS, no liability)

## ⚠️ Disclaimer

This software contains known vulnerabilities. Use entirely at your own risk.

## Features

- Lisp-like syntax with Brainfuck-style operations
- Experimental file input/output
- Intended for research and educational use only

## Output File

The output file is in 8086 format, so please use an MSDOS emulator.

## Syntax (Similar to Brainfuck)

| Syntax | Description |
|--------|-------------|
| `$>`   | Similar to `[>`] |
| `$<`   | Similar to `[<]` |
| `$+`   | Similar to `[+]` |
| `$-`   | Similar to `[-]` |
| `$.`   | Similar to `[.]` |
| `$~`   | Similar to `[,]` (e.g., `($, 20)` allows writing "20") |
| `$_`   | Similar to `nop` |
| `$[`   | Similar to `[[]` |
| `$]`   | Similar to `[]]` |
| `$@`   | Similar to `goto` |
| `$?`   | Similar to `cmp` (Compares the first element of `tbllst`. [Match]: Jump to the next value's program position, [Mismatch]: Proceed to the next program) |
| `$%`   | Moves to the specified table position |
| `$i`   | Similar to `import` |
| `$e`   | Similar to `export` |
| `--`   | Similar to comment (surround with double quotes) |

## Hello World!

```
(
  -- "Hello World! sample"
  -- "AsciiCode"
  $> $~ 32    -- "table[1]: 32->[ ] Setting"
  $> $~ 33    -- "table[2]: 33->[!] Setting"
  $> $~ 72    -- "table[3]: 72->[H] Setting"
  $> $~ 87    -- "table[4]: 87->[W] Setting"
  $> $~ 100   -- "table[5]: 100->[d] Setting"
  $> $~ 101   -- "table[6]: 101->[e] Setting"
  $> $~ 108   -- "table[7]: 108->[l] Setting"
  $> $~ 111   -- "table[8]: 111->[o] Setting"
  $> $~ 114   -- "table[9]: 114->[r] Setting"
  $% 3 $.     -- "Jump to table[3] and print"
  $% 6 $.     -- "Jump to table[6] and print"
  $> $[ $. $] -- "Go to next table and repeat output once"
  $> $.       -- "Go to next table and print"
  $% 1 $.     -- "Jump to table[1] and print"
  $% 4 $.     -- "Jump to table[4] and print"
  $% 8 $.     -- "Jump to table[8] and print"
  $> $.       -- "Go to next table and print"
  $[ $< $] $. -- "Repeat for previous table and print"
  $[ $< $] $. -- "Repeat for previous table and print"
  $% 2 $.     -- "Jump to table[2] and print"
)
```

## import_sample.dat
(32 33 72 87 100 101 108 111 114)

## Release History
2025/02/26： V0.0.1

