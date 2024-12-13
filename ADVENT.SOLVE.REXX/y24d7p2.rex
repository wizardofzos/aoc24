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
okinpartone = ''

p1perms. = ''
p1perms.0 = 0

do i = 1 to file.0
  SAY TIME() i
  parse var file.i equat":" variables
  varlist. = ''
  varlist = ''
  do while variables <> ''
    parse var variables v variables
    varlist = varlist v
  end
  /* cache our perms */
  opers = words(varlist) - 1
  if p1perms.opers <> '' then do
    oper = p1perms.opers
  end
  else do
    oper  = perms('',opers,'*+','')
    p1perms.opers = oper
  end
  amtok = 0
  do k = 1 to words(oper)
    opskips = 0
    ans = word(varlist,1)
    do o = 1 to length(word(oper,k))
      operator = substr(word(oper,k),o,1)
      if operator = '+' then do
        ans = ans + word(varlist,o+1)
      end
      if operator = '*' then do
        ans = ans * word(varlist,o+1)
      end
      if ans > equat then do
        leave o
      end
    end
    end
    if ans = equat then do
      amtok = amtok + 1
      okinpartone = okinpartone i
      leave
    end
  end
  /*
  say file.i "has" amtok "solution"
  */
  if amtok > 0 then part1 = part1 + equat


say "Part One" part1
part2 = 0

p2perms. = ''

do i = 1 to file.0
  parse var file.i equat":" variables
  if wordpos(i,okinpartone) > 0 then iterate
  varlist. = ''
  varlist = ''
  do while variables <> ''
    parse var variables v variables
    varlist = varlist v
  end
  /* Cache tht stuff */
  opers = words(varlist) - 1
  if p2perms.opers <> '' then do
    oper = p2perms.opers
  end
  else do
    say "Calculate" opers "opers" TIME()
    oper  = perms('',opers,'*+¨','')
    p2perms.opers = oper
    say "....done" TIME()
  end
  amtok = 0
  SAY TIME() "line" i words(oper) "permutations to checK"
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
      if operator = '¨' then do
        ans = ans || word(varlist,o+1)
      end
      if ans > equat then leave o
    end
    if ans = equat then do
      amtok = amtok + 1
      leave k
    end
  end
  /*
  say file.i "has" amtok "solution"
  */
  if amtok > 0 then part2 = part2 + equat
end


say "Part Two" part2
say "Part Two + Part 1" part1 + part2
exit


perm2: procedure
  parse arg pfx, remaining, opts,res
  if remaining = 0 then do
    res = res|| pfx || ' '
    return res
  end
  do i = 1 to length(opts)
    res = perms(pfx || substr(opts,i,1), remaining-1,opts,res)
  end
  return res
perms: procedure
  parse arg prefix, remaining, options, result

  /* Base case: If no remaining elements, add the prefix to results */
  if remaining = 0 then return result || prefix || ' '

  /* Loop through options and generate permutations recursively */
  do i = 1 to length(options)
    char = substr(options, i, 1)                     /* Current character */
    result = perms(prefix || char, remaining - 1, options, result)
  end

  return result
