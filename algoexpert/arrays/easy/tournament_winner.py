def tournamentWinner(competitions, results):
    points_tally = {} 

    for idx, competition in enumerate(competitions):
        home_team = competition[0]
        away_team = competition[1]

        if results[idx] == 1:
            points_tally[home_team] = points_tally.get(home_team, 0) + 3
        else:
            points_tally[away_team] = points_tally.get(away_team, 0) + 3

    winning_team = max(points_tally, key=points_tally.get)
    
    return winning_team
    