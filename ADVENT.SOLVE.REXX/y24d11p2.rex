/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/11     |
+-------------------------------------------------*/
say "Advent of Code 2024 day 11"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d11',,file.,se.)

NUMERIC DIGITS 40 /* do we have large nums? */

/* Test Data
file.1 = '125 17'
file.0 = 1 */


stones = file.1
solutions. = ''

part1 = 0
part2 = 0
say TIME() "start part one"
do i = 1 to words(stones)
  part1 = part1 + evolve(word(stones,i),25)
end

say TIME() "Done, answer="part1
say TIME() "start part two"
do i = 1 to words(stones)
  part2 = part2 + evolve(word(stones,i),75)
end
say TIME() "Done, answer="part2

say "Part One:" part1
say "Part Two:" part2

exit

evolve: procedure expose solutions.
  parse arg val,times
  v = val
  t = times
  /* what does val do after times times? */
  select
    when solutions.v.t <> '' then return solutions.v.t
    when times = 0 then ret = 1
    when val = 0 then ret = evolve(1, times-1)
    when length(val) // 2 = 0 then do
      parts = splitit(val)
      parse var parts a b
      ret = evolve(a,times-1) + evolve(b,times-1)
    end
    otherwise do
      ret = evolve(val*2024, times-1)
    end
  end
  /* Cache our result */
  solutions.v.t = ret
  return ret

splitit: procedure
  parse arg w
  l = length(w) / 2
  a = substr(w,1,l)
  b = substr(w,l+1,l)
  b = strip(b,'L','0') /* remove leading zeroes? */
  if b = '' then b = '0'
  return a b
