# Implement a naive baseline that uses last week’s data to perform predictions 
# (e.g. naive prediction for test value on Monday 6pm is identical to previous 
# Monday – i.e. exactly one week ago – 6pm’s value).

import pandas as pd
import numpy as np
from datetime import datetime as dt

def run_forecasting_naive(file, prediction_horizon):
    df = pd.read_csv(file, index_col='datetime')
    df.index = pd.to_datetime(df.index)
    
    days_ago = 7 
    y_actual = df[-prediction_horizon:]
    y_pred = [] 

#     print(f'Actual Dates: {y_actual.index}\n')
#     print(f'Past Dates: {[idx + pd.Timedelta(days=-days_ago) for idx in y_actual.index]}\n')
    
    # use index of actual values to locate values 7 days in the past
    for idx in y_actual.index:
        try:
            past_idx = idx + pd.Timedelta(days=-days_ago)
            pred_val = df.loc[past_idx].values[0]
        except: # return NaN if index is out of bounds or other error occurs
            pred_val = np.nan

        y_pred.append(pred_val)
        
    y_actual = y_actual['MT_1'].values
    y_pred = np.array(y_pred)
        
    rmse = round(np.sqrt(sum( (y_actual - y_pred)**2 ) / len(y_actual)),3)
    
    return rmse

