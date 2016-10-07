import string

input = 'hxbxwxba'

def new_pwd(old_pw):
	alpha = list(string.ascii_lowercase)
	forbidden = ['i','o','l']
	old_pw = old_pw[::-1]

	has_bad = any(c in old_pw for c in forbidden)
	has_dubs = 5
	has_incr = 4

	return {v:k for k,v in list.items()}

print(new_pwd(input))
