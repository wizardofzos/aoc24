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
leftof. = ''

part1 = 0
part2 = 0

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
    else do
      /* Now we need to fix it */
      neworder = fixStrin1(pages)
      say "fixed to" neworder
      middlepos = (words(neworder) + 1) / 2
      part2 = part2 + word(neworder,middlepos)
    end
  end
  if mode = 'rules' then do
    nr = rules.0 + 1
    parse var file.i lft'|'thisone
    rules.nr = lft","thisone
    rules.0 = nr
    if leftof.lft = '' then do
      leftof.lft = thisone
    end
    else do
      leftof.lft = leftof.lft","thisone
    end
  end
end

say "Part One:" part1
say "Part Two:" part2

exit

fixStrin1: procedure expose leftof.
  parse arg inputString

  /* Parse input string into a list */
  words = words(inputString)
  do i = 1 to words
    parse var inputString word.i ' ' inputString
  end

  /* Create a map of word positions in the input string */
  pos. = ''
  do i = 1 to words
    v = word.i
    pos.v = i
  end

  /* Iteratively fix the string until all rules are satisfied */
  fixed = 1
  do while fixed
    fixed = 0

    do i = 1 to words
      currentWord = word.i
      leftWords = leftof.currentWord

      /* If no dependencies, continue */
      if leftWords = '' then iterate

      /* Parse the left dependencies */
      do while leftWords \= ''
        parse var leftWords leftWord ',' leftWords

        /* Skip if dependency is not part of the input */
        if pos.leftWord = '' then iterate

        /* Check if the rule is violated */
        if pos.leftWord > pos.currentWord then do
        /*
          ccww = currentWord
          say "Rule violation detected: " leftWord " must be left of " ccww
        */
          /* Swap positions in word array */
          leftPos = pos.leftWord
          currentPos = pos.currentWord
          temp = word.leftPos
          word.leftPos = word.currentPos
          word.currentPos = temp

          /* Update positions */
          pos.leftWord = currentPos
          pos.currentWord = leftPos

          /* Indicate a fix was made */
          fixed = 1
        end
      end
    end
  end

  /* Rebuild the fixed string */
  outputString = ''
  do i = 1 to words
    outputString = outputString || word.i || ' '
  end

  return strip(outputString, 'T', ' ')
fixString: procedure expose leftof.
  parse arg inputString
  say inputString
  /* Parse input string into a list */
  words = words(inputString)
  do i = 1 to words
    parse var inputString word.i ' ' inputString
  end

  /* Create a map of word positions in the input string */
  pos. = ''
  do i = 1 to words
    v = word.i
    pos.v = i
  end

  /* Iteratively fix the string until all rules are satisfied */
  fixed = 1
  do while fixed
    fixed = 0

    do i = 1 to words
      currentWord = word.i
      leftWords = leftof.currentWord
      /* If no dependencies, continue */
      if leftWords = '' then iterate

      /* Parse the left dependencies */
      do j = 1 to words(leftWords)
        parse var leftWords leftWord ',' leftWords
        /* see if leftWord in our input */
        if wordpos(leftWord, inputString) = 0 then iterate
        /* Check if the rule is violated */
        if pos.leftWord > pos.currentWord then do
          /* Swap positions */
          say "need to swap" pos.leftWord "and" pos.currentWord
          twval = pos.leftWord
          tempWord = word.twval
          cwval = pos.currentWord
          word.twval = word.cwval
          word.cwval = tempWord

          /* Update positions */
          tempPos = pos.leftWord
          pos.leftWord = pos.currentWord
          pos.currentWord = tempPos

          /* Indicate a fix was made */
          fixed = 1
        end
      end
    end
  end

  /* Rebuild the fixed string */
  outputString = ''
  do i = 1 to words
    outputString = outputString || word.i || ' '
  end

  return strip(outputString, 'T', ' ')

fixOrder: procedure expose leftof.
  parse arg pages
  say "Trying to fix" pages
  do p = 1 to words(pages)
    c = word(pages,p)
    say c "should be left of" leftof.c
    do l = 1 to words(leftof.c)
      ll = wordpos(word(leftof.c,l),pages)
      if ll = 0 then iterate
      if p < ll then do
        say "was in good spot"
      end
      else do
        say "not in good spot so we flip"
        neworder = ''
        a = word(leftof.c,1)
        do k = 1 to words(pages)
          mw = word(pages,k)
          if mw = a then do
            neworder = neworder c
          end
          else if mw = x then do
            neworder = neworder a
          end
          else neworder = neworder mw
        end
        say neworder
      end
    end

  end
