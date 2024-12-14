/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/13     |
+-------------------------------------------------*/
say "Advent of Code 2024 day 13"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d13',,file.,se.)


/* Test Data
file.1 = "Button A: X+94, Y+34"
file.2 = "Button B: X+22, Y+67"
file.3 = "Prize: X=8400, Y=5400"
file.4 = ""
file.5 = "Button A: X+26, Y+66"
file.6 = "Button B: X+67, Y+21"
file.7 = "Prize: X=12748, Y=12176"
file.8 = ""
file.9 = "Button A: X+17, Y+86"
file.10 = "Button B: X+84, Y+37"
file.11 = "Prize: X=7870, Y=6450"
file.12 = ""
file.13 = "Button A: X+69, Y+23"
file.14 = "Button B: X+27, Y+71"
file.15 = "Prize: X=18641, Y=10279"
file.0 = 15 */


prizeswonp2 = 0
tokensp2 = 0

do i = 1 to file.0
  if file.i = '' then do
    /* Find out how to reset */
    iterate
  end
  aline = i
  bline = i + 1
  pline = i + 2
  i = i + 2
  parse var file.aline "Button A: X+"axm", Y+"aym
  parse var file.bline "Button B: X+"bxm", Y+"bym
  parse var file.pline "Prize: X="px", Y="py

  /* Now we add xxx to the price locations */
  NUMERIC DIGITS 1000
  px2 = px + 10000000000000
  py2 = py + 10000000000000
  ab2 = solvelinear(axm,aym,bxm,bym,px2,py2)
  parse var ab2 a2 b2
  if ab2 = 0 then do
    iterate
  end
  if pos('.',a2) > 0 | pos('.',b2) > 0 then do
    iterate
  end
  say "win at" a2"xA &" b2"xB"
  prizeswonp2 = prizeswonp2 + 1
  tokensp2 = tokensp2 + (3*a2) + b2
end


say "Part Two Total prizes won:" prizeswonp2
say "Part Two Total tokens spent:" tokensp2
exit


solvelinear: procedure
  parse arg axm,aym,bxm,bym,px,py

  determinator = (axm * bym) - (aym * bxm)

  if determinator = 0 then do
    say "Cannot solve this I guess..."
    return 0
  end

  determ_a = (px * bym) - (py * bxm)
  determ_b = (py * axm) - (px * aym)

  a = determ_a / determinator
  b = determ_b / determinator

  return a b


press: procedure
  parse arg sx,sy,dx,dy,times
  /* Location starting at sx,sy after
     times presses with x modidfier dx and y modifier dy
     stupif way of solving brute force :) kept for educational purposes*/
  nx = sx + (dx * times)
  ny = sy + (dy * times)
  return nx ny


