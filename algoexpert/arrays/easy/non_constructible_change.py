def nonConstructibleChange(coins):
    coins.sort() 
    
    current_constructible_change = 0
    
    for coin in coins:
        if coin > current_constructible_change + 1:
            return current_constructible_change + 1
        else:
            current_constructible_change += coin

    return current_constructible_change + 1
