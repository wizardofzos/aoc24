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

sortl. = 0
sortr. = 0
sortl.0 = file.0
sortr.0 = file.0

/* sort the leftlist */
sortstr = ''
do i = 1 to listl.0
  sortstr = sortstr || '\n'|| listl.i
end
sortl = 'echo "' || sortstr || '" | sort'
x = bpxwunix(sortl,,sorted.,err.)
do i = 2 to sorted.0
  ni = i - 1
  sortl.ni = sorted.i
end

/* sort the rightlist */
sortstr = ''
do i = 1 to listr.0
  sortstr = sortstr || '\n'|| listr.i
end
sortl = 'echo "' || sortstr || '" | sort'
x = bpxwunix(sortl,,sorted.,err.)
do i = 2 to sorted.0
  ni = i - 1
  sortr.ni = sorted.i
end

/* now check dist per pair and add */
part1 = 0
do i = 1 to file.0
  part1 = part1 + abs(sortl.i - sortr.i)
end

/* Solve Part 1 */
say "Part One:" part1
