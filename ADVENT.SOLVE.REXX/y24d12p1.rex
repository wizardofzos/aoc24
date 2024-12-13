/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/12     |
+-------------------------------------------------*/
say "Advent of Code 2024 day 12"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d12',,file.,se.)

/* Smallest Test Data */
file.1 = 'OOOOO'
file.2 = 'OXOXO'
file.3 = 'OOOOO'
file.4 = 'OXOXO'
file.5 = 'OOOOO'
file.0 = 5


map. = '' /* The Map of c.l plotID's */

/* keep track of all plantTypes */
allplants = ''
/* and all regions */
allregions = ''

/* Keep track of plants plant.A is amoutn of plants A
                        amoutn of total plants = plant.0
*/
plant. = ''
plant.0 = 0
/* Keep track of all locations per plantID */
/* locations.A = ".,. .,. .,." (column,row)*/
locations. = ''
/* And of stuff we've checked/parsed/processed */
checked. = 0

/* Our queue for bfs */
queue. = 0


say TIME() "starting file proces and mapbuilding"
do i = 1 to file.0
  do j = 1 to length(file.i)
    map.j.i = substr(file.i,j,1)
    plantid = map.j.i
    if wordpos(plantid,allplants) = 0 then do
      /* this plant not known yet */
      plant.plantid = plantid
      plant.plantid.0 = 1
      plant.plantid.1 = j","i
      allplants = allplants plantid
      say "new plant" plantid
    end
    else do
      /* We already know this plant, add one to amount */
      /* And add to plant count too */
      np = plant.plantid.0 + 1
      plant.plantid.np = j","i
      plant.plantid.0 = np
    end
    plant.0 = plant.0 + 1 /* we have one more plant */
    locations.plantid = locations.plantid j","i
  end
end

db = debuglocations()

ll = TIME()
say ll "Done parsing map," plant.0" plants found"
do i = 1 to words(allplants)
  p = word(allplants,i)
  plant.p.conns = 0
  region.p.0 = 0
  say "  plant: "p"  amount:"plant.p.0
  perim = 0
  ar = 0
  price = 0
  /* Now we have all the locations for this plant */
  /* Find all 'connected sets' for each plant count
     the amount of other plants around it (lrud) */
  checked. = ''
  do m = 1 to plant.p.0
    queue.0 = 0
    coord = plant.p.m
    coord2 = word(locations.p,m)
    say locations.p
    if coord = 0 then do
     /* Something bad happened */
     coord = coord2
    end
    parse var coord c","l
    x = queueit(c,l)
    area = 0
    perimeter = 0
    isolated = 1
    /* Queue Debug */
    do while queue.0 > 0
      /* get first from queue */
      newloc = firstqueue()
      parse var newloc c","l
      /* Did we do this one yet? */
      if checked.c.l = 1 then do
        leave
      end
      checked.c.l = 1
      area = area + 1
      /* check for number of unconnected sides */
      conns = 4
      deltas = "0,1 0,-1 1,0 -1,0"
      do d = 1 to words(deltas)
        /* check all potential connected plots */
        con = word(deltas,d)
        parse var con dc","dl
        nc = c + dc
        nl = l + dl
        /* is this connected ? */
        if wordpos(nc","nl, locations.p) > 0 then do
            isolated = 0
            if checked.nc.nl = 0 then do
              checked.nc.nl = 1
              x = queueit(nc,nl)
            end
            conns = conns - 1
        end
      end
      perimeter = perimeter + conns
    end
    if isolated = 1 then do
      area = 1
      perimeter = 4
      checked.c.l = 1
    end
    say "plant" p "area="area "perimeter="perimeter
end

exit

queueit: procedure expose queue. checked.
  parse arg c,l
  if checked.c.l = 1 then do
    return 0
  end
  say "queueing" c","l
  nq = queue.0 + 1
  queue.nq.0 = c
  queue.nq.1 = l
  queue.0 = nq
  return 0

firstqueue: procedure expose queue. checked.
  /* Get first element from queue (oldest) */
  c = queue.1.0
  l = queue.1.1
  /* Move all other elements 'to the left' */
  do i = 1 to queue.0 - 1
    nq = i + 1
    queue.i.0 = queue.nq.0
    queue.i.1 = queue.nq.1
  end
  /* Minus one on the index */
  queue.0 = queue.0 - 1
  /* mark as checked */
  /* return it */
  return c","l

debuglocations: procedure expose locations. allplants
  do i = 1 to words(allplants)
    pid = word(allplants,i)
    say pid ">" locations.pid
  end
  return 0

debugqueue: procedure expose queue.
  do i = 1 to queue.0
    say i")" queue.i.0 queue.i.1
  end
