def groupAnagrams(words):
    anagram_hash = {} 

    for word in words:
        ordered_word = ''.join(sorted(word))
        if ordered_word in anagram_hash:
            anagram_hash[ordered_word].append(word)
        else:
            anagram_hash[ordered_word] = [word]

    return [vals for vals in anagram_hash.values()]
