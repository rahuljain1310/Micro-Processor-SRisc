import random
result = []

for i in range(100):
	x = random.randint(1,100)
	result.append(x)
# result.sort()
# result.reverse()

# for i in range(100):
# 	print(".encode mov r1, {0}".format(result[i]))
# 	print(".encode st r1, {0}[r0]".format(4*i))

for i in range(50):
	print("ld r1, {0}[r0]".format(4*i))
	print(".print r1")