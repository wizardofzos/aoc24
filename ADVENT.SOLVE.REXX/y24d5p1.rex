/*--------------------------------------------[REXX]
| Made with ZAOC by wizard@zdevops.com             |
| Puzzle: https://adventofcode.com/2024/day/5      |
+-------------------------------------------------*/
say "Advent of Code 2024 day 5"
x = bpxwunix('cat /prj/repos/ZAOC/puzzles/y2024d5',,file.,se.)

/* Test Data
file.1   = '47|53'
file.2   = '97|13'
file.3   = '97|61'
file.4   = '97|47'
file.5   = '75|29'
file.6   = '61|13'
file.7   = '75|53'
file.8   = '29|13'
file.9   = '97|29'
file.10  = '53|29'
file.11  = '61|53'
file.12  = '97|53'
file.13  = '61|29'
file.14  = '47|13'
file.15  = '75|47'
file.16  = '97|75'
file.17  = '47|61'
file.18  = '75|61'
file.19  = '47|29'
file.20  = '75|13'
file.21  = '53|13'
file.22  = ''
file.23  = '75,47,61,53,29'
file.24  = '97,61,53,29,13'
file.25  = '75,29,13'
file.26  = '75,97,47,61,53'
file.27  = '61,13,29'
file.28  = '97,13,75,29,47'
file.0   = 28 */

rules. = 0

part1 = 0
mode = 'rules'
do i = 1 to file.0
  if file.i = '' then do
    /* pages to produce */
    mode = 'pages'
    i = i + 1
  end
  if mode = 'pages' then do
    say '----new set-----'
    pages = translate(file.i,' ',',')
    setok = 1
    do j = 1 to rules.0
      parse var rules.j is","leftof
      isloc = wordpos(is,pages)
      lefloc = wordpos(leftof,pages)
      if isloc > 0 & lefloc > 0 then do
        /* pages from rule is in this set */
        if isloc > lefloc then do
          /* we broke the rules */
          setok = 0
          leave j
        end
      end
    end
    /* if we get here, this set might be ok */
    if setok = 1 then do
      say pages "is ok"
      middlepos = (words(pages) + 1) / 2
      part1 = part1 + word(pages,middlepos)
    end
  end
  if mode = 'rules' then do
    nr = rules.0 + 1
    parse var file.i leftof'|'thisone
    rules.nr = leftof","thisone
    rules.0 = nr
  end
end

say "Part One:" part1
