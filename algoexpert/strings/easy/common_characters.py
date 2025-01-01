def commonCharacters(strings):
    all_unique_chars = {} 

    for string in strings:
        unique_chars = set(string)
        
        for char in unique_chars:
            all_unique_chars[char] = all_unique_chars.get(char, 0) + 1

    common_chars = [char for char, count in all_unique_chars.items() if count == len(strings)]
    
    return common_chars
