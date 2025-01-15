def balancedBrackets(string):
    idx = 1

    bracket_pairs = {
        '(': ')',
        '[': ']',
        '{': '}'
    }

    closing_brackets = [')', ']', '}']

    brackets_to_close = [string[0]]

    while idx < len(string):
        char = string[idx]

        if not brackets_to_close and char in bracket_pairs.values():
            brackets_to_close.append(char)
        
        elif char in closing_brackets and brackets_to_close[-1] in bracket_pairs.keys():
            if char == bracket_pairs[brackets_to_close[-1]]:
                brackets_to_close.pop()
            else:
                return False
        elif char in bracket_pairs.keys() or char in bracket_pairs.values():
            brackets_to_close.append(char)

        idx += 1

    return len(brackets_to_close) == 0
