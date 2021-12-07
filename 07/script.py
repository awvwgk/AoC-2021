import sys, numpy as np
inp = np.array([int(i) for i in open(sys.argv[1]).read().strip().split(",")])

minf1 = np.inf
minf2 = np.inf
for i in range(np.amax(inp)):
    tmp = abs(inp - i)
    minf1 = min(minf1, np.sum(tmp))
    minf2 = min(minf2, sum([i*(i+1)//2 for i in tmp]))

print(minf1)
print(minf2)
