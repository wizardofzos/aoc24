/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/11     |
+-------------------------------------------------*/
say "Advent of Code 2024 day 11"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d11',,file.,se.)

NUMERIC DIGITS 31 /* do we have large nums? */

/* Test Data
file.1 = '125 17'
file.0 = 1 */

stones. = 'X'

do i = 1 to file.0
  call strtostem(file.i)
end

stonelist = stemtostr()

do blink = 1 to 25
  s = stonelist
  ns = ''
  do i = 1 to words(s)
    stone = word(s,i)
    l = length(stone) // 2
    select
      when stone = '0'  then do
        ns = ns '1'
      end
      when l = 0  then do
        ns = ns splitit(stone)
      end
      otherwise do
        ns = ns stone*2024
      end
    end
  end
  if blink // 5 = 0 | blink > 20 then
  say TIME() "After" blink "blinks we have" words(ns) "stones"
  stonelist = ns
end


exit

stemtostr: procedure expose stones.
  l = ''
  do i =1 to stones.0
    l = l stones.i
  end
  return l

strtostem: procedure expose stones.
  parse arg l
  do i = 1 to words(l)
    stones.i = word(l,i)
  end
  stones.0 = i -1
  say 'strtostem done'
  return

splitit: procedure
  parse arg w
  l = length(w) / 2
  a = substr(w,1,l)
  b = substr(w,l+1,l)
  b = strip(b,'L','0') /* remove leading zeroes? */
  if b = '' then b = '0'
  return a b

splitstone: procedure
  parse arg stonestr,at
  newstr = ''
  do i = 1 to words(stonestr)
    if i <> at then do
      newstr = newstr word(stonestr,i)
    end
    else do
      /* split according to rule */
      w = word(stonestr,i)
      l = length(w) / 2
      a = substr(w,1,l)
      b = substr(w,l+1,l)
      b = strip(b,'L','0') /* remove leading zeroes? */
      if b = '' then b = '0'
      newstr = newstr a b
    end
  end
  return newstr
