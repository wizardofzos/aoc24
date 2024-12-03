/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/3      |
+-------------------------------------------------*/
say "Advent of Code 2024 day 3"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d3',,file.,se.)

part1 = 0

/* Test data
file.1 = 'xmul(2,4)%&mul¢3,7!|@^do_not_mul(5,5)',
         '+mul(32,64!then(mul(11,8)mul(8,5))'
file.0 = 1 */

part1 = 0

do i = 1 to file.0
  parse var file.i muck'mul('rest
  parse var rest m','n')'remain
  if datatype(m) = 'NUM' & datatype(n) = 'NUM' then do
    part1 = part1 + (m*n)
  end
  else do
    remain = rest
  end
  do while remain <> ''
    parse var remain muck'mul('rest
    parse var rest m','n')'remain
    if datatype(m) = 'NUM' & datatype(n) = 'NUM' then do
      part1 = part1 + (m*n)
    end
    else do
      remain = rest
    end
  end
end

say "Part One:" part1
