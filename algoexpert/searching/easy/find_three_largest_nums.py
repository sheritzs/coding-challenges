def findThreeLargestNumbers(array):
    three_largest_nums = sorted(array[:3])

    for num in array[3:]:
        if num > three_largest_nums[0]:
            three_largest_nums[0] = num 
            three_largest_nums.sort()

    return three_largest_nums
