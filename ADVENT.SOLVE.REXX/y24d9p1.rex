/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/9      |
+-------------------------------------------------*/
say "Advent of Code 2024 day 9"
/* File is 'too wide' so split it first */
/* make sure to split at 'even' lengths*/
ff = '/prj/repos/ZAOC/puzzles/y2024d9'
foldsize = 10
x = bpxwunix('cat' ff ' | fold -w 'foldsize,,file.,se.)
NUMERIC DIGITS 16
/* Test Data (try split, as file too long....)
file.1 = '2333133121'
file.2 = '414131402'
file.0 = 2 */


blocks. = '.'
blocks.0 = 0

ID = 0
say TIME() "Processing chunks"
mapl = 0
do i = 1 to file.0
  if i // 10000 = 0 then
  say "  " TIME() "chunck of" length(file.i)
  do j = 1 to length(file.i)
  mapl = mapl + 1
    mapval = substr(file.i,j,1)
    if j // 2  = 0 then do
      /* odd position, freespace */
    /*say "empty at map" j "with len" mapval*/
      do f = 1 to mapval
        nbpos = blocks.0 + 1
        blocks.nbpos = '.'
        blocks.0 = nbpos
      end
    end
    else do
      /* even position, filedata */
    /*say "filedata  at map" j "with len" mapval "curID="ID*/
      do f = 1 to mapval
        nbpos = blocks.0 + 1
        blocks.nbpos = ID
        blocks.0 = nbpos
      end
      ID = ID + 1
    end
  end
end

say TIME() "Total blocks:" blocks.0
say TIME() "Max FID:" ID
/* print Drive
l = ''
do j = 1 to blocks.0
  l = l || blocks.j
end
say l */



say TIME() "Map processed, length="mapl
say TIME() "Start compressing..." blocks.0 "blocks"

/* Compress that shit right to left */
firstfree = 1
newdrive = ''
do i = blocks.0 to 1 by -1
  v = blocks.0 - i
  pct = (v/blocks.0) * 100
  if v //10000= 0 then do
    say "  - "TIME() v"/"blocks.0 "done ("pct"%)"
  end
  diskval = blocks.i
  if diskval = '.' then do
    iterate
  end
  /* find free block */
  do s = firstfree to blocks.0
    if blocks.s = '.' then do
      blocks.s = diskval
      blocks.i = '.'
      firstfree = s
      leave s
    end
    if firstfree = i then do
      say "trigger"
      do z = i +1 to blocks.0
        blocks.z = '.'
      end
      leave i
    end
  end
end
say "  - "TIME() "all blocks compressed"
say "  - "TIME() "firstfree ="firstfree
say "Final Checksum (part1):" checkSun(firstfree)

exit

printDrive: procedure expose blocks.
  /* print Drive */
  l = ''
  do j = 1 to blocks.0
    l = l || blocks.j
  end
  return l


checkSum: procedure expose blocks.
  parse arg drive
  chksum = 0
  ll = ''
  do a = 1 to length(drive)
    b   = a - 1
    fid = substr(drive,a,1)
    if fid = '.' then iterate
    ll = ll "/" y "*" fid
    say "Adding "y"*"fid "to checksum  ("chksum"+"y*fid")"
    chksum = chksum + (y * fid)
  end
  return chksum

checkSun: procedure expose blocks.
  chksum = 0
  parse arg upto
  ll = ''
  do a = 1 to upto /* was blocks.0 */
    y   = a - 1
    fid = blocks.a
    if fid = '.' then iterate
    ll = ll "/" y "*" fid
    /*
    say "Adding "y"*"fid "to checksum  ("chksum"+"y*fid")"
    */
    chksum = chksum + (y * fid)
  end
  return chksum
