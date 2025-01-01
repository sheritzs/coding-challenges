def binarySearch(array, target):
    left_idx = 0
    right_idx = len(array) - 1

    while left_idx <= right_idx:
        mid_idx = (left_idx + right_idx) // 2
        mid_val = array[mid_idx]
        if mid_val == target:
            return mid_idx 
        elif mid_val > target:
            right_idx = mid_idx - 1
        else:
            left_idx = mid_idx + 1
            
    return -1
