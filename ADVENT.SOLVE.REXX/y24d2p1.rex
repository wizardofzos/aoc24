/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
+-------------------------------------------------*/
say "Advent of Code 2024 day 2"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d2',,file.,se.)

/* test data
file.1 = '7 6 4 2 1'
file.2 = '1 2 7 8 9'
file.3 = '9 7 6 2 1'
file.4 = '1 3 2 4 5'
file.5 = '8 6 4 4 1'
file.6 = '1 3 6 7 9'
file.0 = 6 */

part1 = 0

do i = 1 to file.0
  report = file.i
  /* We're unsafe by default */
  safe = 0
  /* Determine first two levels */
  a = word(report,1)
  b = word(report,2)
  /* ASC or DESC? */
  if a > b then
    type = 'D'
  if a < b then
    type = 'A'
  if a = b then
    iterate    /* Not a safe report go to next */
  /* get all the following levels */
  checked = 1
  do j = 2 to words(report)
    b = word(report,j)
    if type = 'D' then do
      if a - b > 0 & a - b < 4 then do
        a = b        /* move one forward */
      end
      else do
        leave /* unsafe, go to next report */
      end
    end
    if type = 'A' then do
      if b - a > 0 & b - a < 4 then do
        a = b        /* move one forward */
      end
      else do
        leave /* unsafe, go to next report */
      end
    end
    checked = checked + 1
  end
  say "loop done, checked" checked "out of" words(report)
  if checked = words(report) then do
    part1 = part1 + 1
  end
end

say "Part One:" part1
