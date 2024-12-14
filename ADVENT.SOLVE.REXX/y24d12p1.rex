/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/12     |
+-------------------------------------------------*/
say "Advent of Code 2024 day 12"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d12',,file.,se.)

/* test */

/* Smallest Test Data
file.1 = 'OOOOO'
file.2 = 'OXOXO'
file.3 = 'OOOOO'
file.4 = 'OXOXO'
file.5 = 'OOOOO'
file.0 = 5 */

map. = '' /* The Map of c.l plotID's */

/* Keep track of all plantTypes */
allplants = ''
locations. = '' /* Store plant locations by plantID */
checked. = '' /* Tracks checked locations */
queue. = '' /* BFS queue */

/* Build the map */
say TIME() "Starting file processing and map building..."
do i = 1 to file.0
  do j = 1 to length(file.i)
    plantid = substr(file.i, j, 1)
    map.j.i = plantid

    if wordpos(plantid, allplants) = 0 then do
      /* New plant type */
      allplants = allplants plantid
      locations.plantid = j","i
    end
    else
      locations.plantid = locations.plantid || " " || j","i
  end
end

/*
call debuglocations
*/
say TIME() "Done parsing map."

part1 = 0

/* Process each plant type */
do i = 1 to words(allplants)
  plantid = word(allplants, i)
  totalArea = 0
  totalPerimeter = 0
  checked. = '' /* Reset checked map for each plant */

  say "Processing plant:" plantid
  region.plantid.0 = 0
  do j = 1 to words(locations.plantid)
    coord = word(locations.plantid, j)
    parse var coord c "," l
    /* Skip if already checked */
    if checked.c.l = 1 then iterate

    npr = region.plantid.0 + 1
    region.plantid.npr.0 = 0           /* store perimeter */
    region.plantid.npr.1 = 0          /* store area */
    regionArea = 0
    regionPerimeter = 0

    /* Start BFS for this region */
    queue.0 = 0
    x = queueit(c, l)

    do while queue.0 > 0
      /* during this loop, we're a connected set */
      newloc = firstqueue()
      parse var newloc c "," l
      /* Skip if already checked */
      if checked.c.l = 1 then iterate
      checked.c.l = 1 /* log we've done this one */
      /* Increment area */
      regionArea = regionArea + 1
      /* Check connections */
      conns = 4
      deltas = "0,1 0,-1 1,0 -1,0"
      do d = 1 to words(deltas)
        con = word(deltas, d)
        parse var con dc "," dl
        nc = c + dc
        nl = l + dl
        /* Check neighbor */
        if isNeighbor(nc, nl, plantid) then do
          if checked.nc.nl <> 1 then do
            x = queueit(nc, nl) /* Enqueue the neighbor */
          end
          conns = conns - 1
        end
      end
      regionPerimeter = regionPerimeter + conns
    end
    if regionArea > 0 then do
      say "Comp region:" np "Area=" regionArea "Perimeter=" regionPerimeter
      part1 = part1 + (regionArea*regionPerimeter)
    end
  end

    /* Accumulate totals */
    totalArea = totalArea + regionArea
    totalPerimeter = totalPerimeter + regionPerimeter

  /* Output totals for the plant */
  say "Plant" plantid ": Total A=" totalArea ", Total P=" totalPerimeter
end

say "Part One:" part1
exit

/* Queue functions */
queueit: procedure expose queue. checked.
  parse arg c, l
  if checked.c.l = 1 then return 0
  nq = queue.0 + 1
  queue.nq.0 = c
  queue.nq.1 = l
  queue.0 = nq
  return 0

firstqueue: procedure expose queue.
  c = queue.1.0
  l = queue.1.1
  do i = 1 to queue.0 - 1
    nq = i + 1
    queue.i.0 = queue.nq.0
    queue.i.1 = queue.nq.1
  end
  queue.0 = queue.0 - 1
  return c "," l

isNeighbor: procedure expose locations.
  parse arg nc, nl, plantid
  if wordpos(nc","nl, locations.plantid) > 0 then return 1
  return 0

debuglocations: procedure expose locations. allplants
  do i = 1 to words(allplants)
    pid = word(allplants, i)
    say pid ">" locations.pid
  end
  return 0

debugqueue: procedure expose queue.
  do i = 1 to queue.0
    say i")" queue.i.0 "," queue.i.1
  end
  return 0
