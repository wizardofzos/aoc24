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

part1 = 0

/* Build our map.. */
do i = 1 to file.0
  do j = 1 to length(file.i)
    map.i.j = substr(file.i,j,1)
  end
end

/* map.p.q = line p position q */

do l = 1 to file.0
  do p = 1 to length(file.1)
    p1 = p + 1
    p2 = p + 2
    p3 = p + 3
    /* left to right */
    if map.l.p = 'X' & map.l.p1 = 'M' & map.l.p2 = 'A' & map.l.p3 = 'S'
    then do
      part1 = part1 + 1
  /*  say "Found XMAS at line" l "on pos" p "L2R" */
    end
    /* right to left */
    if map.l.p = 'S' & map.l.p1 = 'A' & map.l.p2 = 'M' & map.l.p3 = 'X'
    then do
      part1 = part1 + 1
  /*  say "Found XMAS at line" l "on pos" p "R2L" */
    end
  end
end
/* top to bottom */
do p = 1 to length(file.1)
  do l = 1 to file.0
    l1 = l + 1
    l2 = l + 2
    l3 = l + 3
    /* top to bottom */
    if map.l.p = 'X' & map.l1.p = 'M' & map.l2.p = 'A' & map.l3.p = 'S'
    then do
  /*  say "Found XMAS as line" l "position" p "T2B" */
      part1 = part1 + 1
    end
    /* bottom to top */
    if map.l.p = 'S' & map.l1.p = 'A' & map.l2.p = 'M' & map.l3.p = 'X'
    then do
  /*  say "Found XMAS as line" l "position" p "B2T" */
      part1 = part1 + 1
    end
  end
end
/* diagonals Down Right */
do l = 1 to file.0
  do p = 1 to length(file.1)
    p1 = p + 1
    p2 = p + 2
    p3 = p + 3
    m = l + 1
    n = l + 2
    o = l + 3
    /* left to right */
    if map.l.p = 'X' & map.m.p1 = 'M' & map.n.p2 = 'A' & map.o.p3 = 'S'
    then do
      part1 = part1 + 1
  /*  say "Found XMAS at line" l "on pos" p "DR" */
    end
    /* right to left */
    if map.l.p = 'S' & map.m.p1 = 'A' & map.n.p2 = 'M' & map.o.p3 = 'X'
    then do
      part1 = part1 + 1
  /*  say "Found XMAS at line" l "on pos" p "DR (reverse)" */
    end
  end
end
/* diagonals Up   Right */
do l = 1 to file.0
  do p = 1 to length(file.1)
    p1 = p + 1
    p2 = p + 2
    p3 = p + 3
    m = l - 1
    n = l - 2
    o = l - 3
    /* left to right */
    if map.l.p = 'X' & map.m.p1 = 'M' & map.n.p2 = 'A' & map.o.p3 = 'S'
    then do
      part1 = part1 + 1
  /*  say "Found XMAS at line" l "on pos" p "UR" */
    end
    /* right to left */
    if map.l.p = 'S' & map.m.p1 = 'A' & map.n.p2 = 'M' & map.o.p3 = 'X'
    then do
      part1 = part1 + 1
  /*  say "Found XMAS at line" l "on pos" p "UR (reverse)" */
    end
  end
end


say "Solution part1" part1

/* Print the map
say "0 1 2 3 4 5 6 7 8 9 A"
do p = 1 to file.0
  line = p
  if line = 10 then line = 'A'
  do q = 1 to file.0
    line = line || ' ' || map.p.q
  end
  say line
end  */
exit

do i = 1 to file.0
  say file.i
end
