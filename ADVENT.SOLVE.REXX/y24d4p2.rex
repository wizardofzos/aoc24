/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/4      |
+-------------------------------------------------*/
say "Advent of Code 2024 day 4"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d4',,file.,se.)

/* test data
file.1 = 'MMMSXXMASM'
file.2 = 'MSAMXMSMSA'
file.3 = 'AMXSXMAAMM'
file.4 = 'MSAMASMSMX'
file.5 = 'XMASAMXAMM'
file.6 = 'XXAMMXXAMA'
file.7 = 'SMSMSASXSS'
file.8 = 'SAXAMASAAA'
file.9 = 'MAMMMXMMMM'
file.10= 'MXMXAXMASX'
file.0 = 10 */

map. = '0'

part2 = 0

/* Build our map.. */
do i = 1 to file.0
  do j = 1 to length(file.i)
    map.i.j = substr(file.i,j,1)
  end
end

/* map.p.q = line p position q */

do l = 1 to file.0
  do p = 1 to length(file.1)
    /* check for pattern 1 */
    p1 = p + 1
    p2 = p + 2
    l1 = l + 1
    l2 = l + 2
    if map.l.p = "M" & map.l.p2 = "S" &,
       map.l1.p1 = "A" &,
       map.l2.p = "M" & map.l2.p2 = "S" then
    do
      part2 = part2 + 1
    end
    /* check for pattern 2 */
    if map.l.p = "S" & map.l.p2 = "S" &,
       map.l1.p1 = "A" &,
       map.l2.p = "M" & map.l2.p2 = "M" then
    do
      part2 = part2 + 1
    end
    /* check for pattern 3 */
    if map.l.p = "M" & map.l.p2 = "M" &,
       map.l1.p1 = "A" &,
       map.l2.p = "S" & map.l2.p2 = "S" then
    do
      part2 = part2 + 1
    end
    /* check for pattern 4 */
    if map.l.p = "S" & map.l.p2 = "M" &,
       map.l1.p1 = "A" &,
       map.l2.p = "S" & map.l2.p2 = "M" then
    do
      part2 = part2 + 1
    end
  end
end

say "Part two:" part2
