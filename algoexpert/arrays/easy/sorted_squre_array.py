def sortedSquaredArray(array):
    sorted_array = [float('-inf') for x in array] 
    left_idx = 0
    right_idx = len(array) - 1

    for idx in reversed(range(len(array))):
        left_val = array[left_idx] ** 2
        right_val = array[right_idx] ** 2

        if left_val > right_val:
            sorted_array[idx] = left_val
            left_idx += 1 
        else:
            sorted_array[idx] = right_val
            right_idx -= 1 

    return sorted_array
