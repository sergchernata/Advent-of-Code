# containers = [47, 46, 44, 44, 43, 41, 38, 36, 34, 31, 27, 21, 17, 17, 10, 9, 6, 4, 4, 3]
# total_eggnog = 150

containers = [20, 15, 10, 5, 5]
total_eggnog = 25

combinations = 0
current = 0

def find_combinations(containers, current, combinations, total_eggnog, i = 0):
	if sum(containers) < total_eggnog:
		return combinations

	current = containers[0]
	subset = list(containers[i+1:])

	for s in subset:
		print(s)
		# we've reached the goal, return
		if current + s == total_eggnog:
			combinations += 1
		# still less than the goal, continue
		elif current + s < total_eggnog:
			current += s
			i += 1
			find_combinations(containers, current, combinations, total_eggnog, i)
		#exceeded the goal, start anew if not the end
		elif current + s > total_eggnog:
			if len(subset) > 1:
				containers.pop(0)
				find_combinations(containers, current, combinations, total_eggnog)
			else:
				return combinations

combinations = find_combinations(containers, current, combinations, total_eggnog)

print(combinations)
