def transposeMatrix(matrix):
    num_rows = len(matrix)
    num_cols = len(matrix[0])

    transposed_matrix = [] 

    for col in range(num_cols):
        new_row = []
        for row in range(num_rows):
            new_row.append(matrix[row][col])
        transposed_matrix.append(new_row)

    return transposed_matrix 
