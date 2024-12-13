/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/7      |
+-------------------------------------------------*/

NUMERIC DIGITS 16

say "Advent of Code 2024 day 7"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d7',,file.,se.)

/* Test data
file.1 = '190: 10 19'
file.2 = '3267: 81 40 27'
file.3 = '83: 17 5'
file.4 = '156: 15 6'
file.5 = '7290: 6 8 6 15'
file.6 = '161011: 16 10 13'
file.7 = '192: 17 8 14'
file.8 = '21037: 9 7 18 13'
file.9 = '292: 11 6 16 20'
file.0 = 9 */

part1 = 0

do i = 1 to file.0
  SAY TIME() i
  parse var file.i equat":" variables
  varlist. = ''
  varlist = ''
  do while variables <> ''
    parse var variables v variables
    varlist = varlist v
  end
  /* testing */
  opers = words(varlist) - 1
  oper  = perms('',opers,'*+','')
  amtok = 0
  do k = 1 to words(oper)
    ans = word(varlist,1)
    do o = 1 to length(word(oper,k))
      operator = substr(word(oper,k),o,1)
      if operator = '+' then do
        ans = ans + word(varlist,o+1)
      end
      if operator = '*' then do
        ans = ans * word(varlist,o+1)
      end
    end
    if ans = equat then do
      amtok = amtok + 1
    end
  end
  /*
  say file.i "has" amtok "solution"
  */
  if amtok > 0 then part1 = part1 + equat
end


say "Part One" part1
exit


perms: procedure
  parse arg pfx, remaining, opts,res
  if remaining = 0 then do
    res = res|| pfx || ' '
    return res
  end
  do i = 1 to length(opts)
    res = perms(pfx || substr(opts,i,1), remaining-1,opts,res)
  end
  return res
