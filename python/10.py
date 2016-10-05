input = '1321131112'

def look_and_say(input):
	output = ''
	char = input[0]
	count = 1
	input = input[1:]
	cursor = 0

	for x in input:
		if char != x:
			output += str(count) + char
			char = x
			count = 1
			if cursor == len(input)-1: output += str(count) + char
		else:
			count += 1

		cursor += 1

	return output

for _ in range(40):
	input = look_and_say(input)

print(len(input))