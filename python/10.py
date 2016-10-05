def look_and_say(repeat):

	input = '1321131112'

	for _ in range(repeat):
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

		input = output

	return len(input)


print(look_and_say(40),look_and_say(50))