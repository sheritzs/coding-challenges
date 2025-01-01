def twoNumberSum(array, targetSum):
    differences = {} 

    for num in array:
        diff = targetSum - num
        if num in differences.keys() and num != diff:
            return [num, differences[num]]
        else:
            differences[diff] = num
    
    return []
