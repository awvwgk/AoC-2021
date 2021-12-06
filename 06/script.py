import sys, numpy as np

t0, t1, t2 = 1, 80, 256
pop = np.zeros(9, dtype=int)
for j in [int(i) for i in open(sys.argv[1]).read().strip().split(",")]:
    pop[j-1] += 1

grow = np.array(
    [  # 1  2  3  4  5  6  7  8  9
        [0, 1, 0, 0, 0, 0, 0, 0, 0],  # 1 -> 7, 9
        [0, 0, 1, 0, 0, 0, 0, 0, 0],  # 2 -> 1
        [0, 0, 0, 1, 0, 0, 0, 0, 0],  # 3 -> 2
        [0, 0, 0, 0, 1, 0, 0, 0, 0],  # 4 -> 3
        [0, 0, 0, 0, 0, 1, 0, 0, 0],  # 5 -> 4
        [0, 0, 0, 0, 0, 0, 1, 0, 0],  # 6 -> 5
        [1, 0, 0, 0, 0, 0, 0, 1, 0],  # 7 -> 6
        [0, 0, 0, 0, 0, 0, 0, 0, 1],  # 8 -> 7
        [1, 0, 0, 0, 0, 0, 0, 0, 0],  # 9 -> 8
    ]
)

for i in range(t1-t0):
    pop = grow.dot(pop)

print(sum(pop))

for i in range(t2-t1):
    pop = grow.dot(pop)

print(sum(pop))
