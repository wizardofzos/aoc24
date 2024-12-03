import re

with open('/prj/repos/ZAOC/puzzles/y2024d3') as f:
  badmem = f.read()

onlyEnabled = re.sub(r"don't\(\).*?do\(\)", "", badmem, flags=re.DOTALL)
muls = re.findall(r"mul\((\d{1,3}),(\d{1,3})\)",onlyEnabled)

print("part two:", sum([int(m) * int(n) for m,n in muls]))

