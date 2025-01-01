def isValidSubsequence(array, sequence):
    array_pointer = 0
    counter = 0
    seq_pointer = 0

    for num in array:
        if num == sequence[seq_pointer]:
            counter += 1
            seq_pointer += 1

        if counter == len(sequence):
            return True

    return False 
    



    
