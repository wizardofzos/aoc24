/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/6      |
+-------------------------------------------------*/
say "Advent of Code 2024 day 6"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d6',,file.,se.)

/* Test data
file.   = 0
file.1  = '....#.....'
file.2  = '.........#'
file.3  = '..........'
file.4  = '..#.......'
file.5  = '.......#..'
file.6  = '..........'
file.7  = '.#..^.....'
file.8  = '........#.'
file.9  = '#.........'
file.10 = '......#...'
file.0  = 10 */

gpos = ""
gdir = '-1,0' /* -1,0 => North
                 0,1  => East
                 1,0  => South
                 0,-1 => West
              */
visited = ''
/* Build our map.. */
/* map.l.p = line l position p */
do l = 1 to file.0
  do p = 1 to length(file.l)
    map.l.p = substr(file.l,p,1)
    if map.l.p = '^' then do
      /* starting pos of our guard */
      gpos = l","p
      /* We've been here before ;) */
      visited = addVisit(gpos, visited)
      /* It's afree spot aftert move */
      map.l.p = '.'
    end
  end
end

/* Start moving the guard untill out of map */
parse var gpos gline","gcol
do while gcol >0 & gcol <=length(file.1) &,
         gline > 0 & gline <=file.0
  newpos = move()
  gpos = newpos
  visited = addVisit(gpos, visited)
  parse var gpos gline","gcol
end

say "Part 1:" words(visited)

exit

move: procedure expose map. gpos gdir
  /* returns new position (if any) and
     changes direction of guard if needed
  */
  /* what spot to look at depends on gdir */
  parse var gdir ld","cd
  parse var gpos cl","cc
  /* add move vector to our guard pos */
  nl = cl + ld
  nc = cc + cd
  /* now we could hit a barrier (#) or freespace */
  if map.nl.nc = '.' then return nl","nc
  if map.nl.nc = "#" then do
    /* we've hit a barrier, turn right */
    if gdir = '-1,0' then ngdir = '0,1'
    if gdir = '0,1' then ngdir = '1,0'
    if gdir = '1,0' then ngdir = '0,-1'
    if gdir = '0,-1' then ngdir = '-1,0'
    gdir = ngdir
    return gpos
  end


addVisit:
  parse arg a,b
  /* a = coordinate in the form "x,y"
     b = list of visted locations
  */
  if wordpos(a,b) = 0 then do
    /* This position is not in the list, add it */
    b = b a
  end
  return b
