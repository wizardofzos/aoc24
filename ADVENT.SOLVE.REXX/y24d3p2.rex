/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/3      |
+-------------------------------------------------*/
say "Advent of Code 2024 day 3"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d3',,file.,se.)

part1 = 0

/* Test data
file.1 = "xmul(2,4)&mul¢3,7!|^don't()_mul(5,5)",
         "+mul(32,64!(mul(11,8)undo()?mul(8,5))"
file.0 = 1 */

part1 = 0

enable = 1

do i = 1 to file.0
  parse var file.i muck'mul('rest
  parse var rest m','n')'remain
  if datatype(m) = 'NUM' & datatype(n) = 'NUM' then do
    on  = index(muck,'do')
    off = index(muck,"don't")
    if on >  0 & off = 0 then do
      enable = 1
    end
    if on >  0 and on = off then do
      enable = 0
    end
    part1 = part1 + (m*n)
  end
  else do
    remain = rest
  end
  do while remain <> ''
    parse var remain muck'mul('rest
    parse var rest m','n')'remain
    if datatype(m) = 'NUM' & datatype(n) = 'NUM' then do
      on  = index(muck,'do')
      off = index(muck,"don't")
      if on >  0 & off = 0 then do
        enable = 1
      end
      if on >= 0 and on = off then do
        enable = 0
      end
      if enable = 1 then
        part1 = part1 + (m*n)
    end
    else do
      remain = rest
    end
  end
end

say "Part One:" part1
