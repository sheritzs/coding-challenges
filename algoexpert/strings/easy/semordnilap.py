def semordnilap(words):
    pairs = {} 
    
    for word in words:
        reversed_word = word[::-1]
        if reversed_word in pairs.keys():
            pairs[reversed_word].append(word)
        else:
            pairs[word] = [word]

    s_pairs = [vals for vals in pairs.values() if len(vals) > 1]

    return s_pairs
