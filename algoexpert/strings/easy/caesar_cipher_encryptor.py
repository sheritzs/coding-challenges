def caesarCipherEncryptor(string, key):
    new_chars = [] 
    starting_point = ord('a') - 1
    max_ord = ord('z')

    for char in string:
        new_ord = ord(char) + key
        if new_ord > max_ord:
            new_ord = starting_point + (new_ord - max_ord) % 26

        new_chars.append(chr(new_ord))

    return ''.join(new_chars)
