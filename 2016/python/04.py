import hashlib

input = 'ckczppom'
found = False
i = 0

while not found:
    hash = hashlib.md5( (input+str(i)).encode() ).hexdigest()
    if hash.startswith('000000'):
        break

    i += 1

print(i)