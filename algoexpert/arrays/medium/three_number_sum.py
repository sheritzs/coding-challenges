def threeNumberSum(array, targetSum):
    array.sort() 
    triplets = []

    for idx1, val1 in enumerate(array):
        left_idx = idx1 + 1 
        right_idx = len(array) - 1

        while left_idx < right_idx:
            val2 = array[left_idx]
            val3 = array[right_idx]
            summed = val1 + val2 + val3

            if summed == targetSum:
                triplets.append([val1, val2, val3])
                left_idx += 1
                right_idx -= 1
            elif summed > targetSum:
                right_idx -= 1
            else:
                left_idx += 1

    return triplets

