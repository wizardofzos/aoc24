/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/10     |
+-------------------------------------------------*/
say "Advent of Code 2024 day 10"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d10',,file.,se.)

/* Test Data
file.1= '89010123'
file.2= '78121874'
file.3= '87430965'
file.4= '96549874'
file.5= '45678903'
file.6= '32019012'
file.7= '01329801'
file.8= '10456732'
file.0= 8 */

/* Build our map */
map. = 'X'
trailheads. = ''
trailheads.0 = 0

do i = 1 to file.0
  do j = 1 to length(file.i)
    map.j.i = substr(file.i,j,1)
    if map.j.i = '0' then do
      /* we found a trailhead */
      nth = trailheads.0 + 1
      trailheads.nth = j","i
      trailheads.0 = nth
    end
  end
end

/* Debug Test */
say "Map parsed," trailheads.0 "trailheads found"
part1 = 0
part2 = 0
do t = 1 to trailheads.0
  tgtnines = 0
  parse var trailheads.t c","l
  paths = trails(c,l)
  targets  = ''
  part2 = part2 + words(paths)
  do q = 1 to words(paths)
    pth = word(paths,q)
    pth = translate(pth,'  ','->')
    lastpoint = word(pth,words(pth))
    if wordpos(lastpoint, targets) = 0 then do
      targets = targets lastpoint
      tgtnines = tgtnines + 1
    end
  end
  part1 = part1 + tgtnines
end

say "Part One:" part1
say "Part Two:" part2

exit

trails: procedure expose map. file.
  parse arg sc, sl

  valids. = ''
  valids.0 = 0

  stack.0 = 1
  stack.1 = sc","sl

  do while stack.0 > 0
    /* pop the top baby */
    top = stack.0
    curpath = stack.top
    stack.0 = stack.0 - 1

    lastd   = lastpos('->', curpath)
    if lastd > 0 then do
      lastp = substr(curpath, lastd + 2)
    end
    else do
      lastp = curpath
    end

    parse var lastp cc","cl
    cv = map.cc.cl

    if cv = 'X' then iterate
    if cv = 9 then do
      have = 0
      do v = 1 to valids.0
        if valids.v = curpath then do
          have = 1
        end
      end
      if have = 0 then do
        nvix = valids.0 + 1
        valids.nvix = curpath
        valids.0 = nvix
      end
      iterate
    end

    /* Move vectors */
    d.1 = "0,-1"
    d.2 = "0,1"
    d.3 = "-1,0"
    d.4 = "1,0"
    do i = 1 to 4
      parse var d.i dc","dl
      nc = cc + dc
      nl = cl + dl
      if map.nc.nl = 'X' then iterate /* to far! */
      nv = map.nc.nl
      np = nc","nl
      if nv = cv + 1 & pos(np, curpath) = 0 then do
        ns = stack.0 + 1
        stack.ns = curpath || '->' || np
        stack.0=ns
      end
    end




  end

  out = ''
  do i = 1 to valids.0
    out = out || valids.i || ' '
  end
  return out

