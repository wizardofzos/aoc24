/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
+-------------------------------------------------*/
say "Advent of Code 2024 day 1"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d1',,file.,se.)

/* fake input
file.1 = '3   4'
file.2 = '4   3'
file.3 = '2   5'
file.4 = '1   3'
file.5 = '3   9'
file.6 = '3   3'
file.0 = 6 */

listl. = 0
listr. = 0

do i = 1 to file.0
  parse var file.i leftitem rightitem
  listl.i = leftitem
  listr.i = rightitem
end

listl.0 = file.0
listr.0 = file.0

part2 = 0
do i = 1 to listl.0
  times = 0
  do j = 1 to listr.0
    if listl.i = listr.j then do
      times = times + 1
    end
  end
  part2 = part2 + (listl.i * times)
end

say "Part 2:" part2
