def generateDocument(characters, document):

    char_count_c = {}
    char_count_doc = {}

    for char in characters:
        char_count_c[char] = char_count_c.get(char, 0) + 1

    for char in document:
        char_count_doc[char] = char_count_doc.get(char, 0) + 1

    for char, count in char_count_doc .items():
        if char not in char_count_c.keys() or count > char_count_c[char]:
            return False


    return True 
