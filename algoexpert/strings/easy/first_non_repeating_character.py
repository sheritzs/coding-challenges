def firstNonRepeatingCharacter(string):
    character_counts = {chr(ord_val):0 for ord_val in range(ord('a'), ord('z') + 1)}

    for char in string:
        character_counts[char] += 1

    for idx, char in enumerate(string):
        if character_counts[char] == 1:
            return idx

    return -1
