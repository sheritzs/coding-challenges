# Implement a linear regression model (e.g., from the scikit learn library) 
# using a set of extracted features including, but not limited to day of the 
# week, hour of the day, week of the day (see lecture slides for other 
# features you may consider; you do not need to one hot encode the features 
# in this case). Do NOT use lagged input (e.g., values from the preceding
# time steps) as extracted features.

import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression


def run_forecasting_linear_regression(file, prediction_horizon):
    df = pd.read_csv(file, index_col='datetime')
    df.index = pd.to_datetime(df.index)
    df['month'] = df.index.month
    df['weekday'] = df.index.weekday
    df['hour'] = df.index.hour
    
    X_train = df.iloc[:, 1:].values[:-prediction_horizon]
    y_train = df[['MT_1']].values[:-prediction_horizon]
    
    X_test = df.iloc[:, 1:].values[-prediction_horizon:]
    y_test = df[['MT_1']].values[-prediction_horizon:]
    
    lin_reg_model = LinearRegression()
    lin_reg_model.fit(X_train, y_train)
    y_pred = lin_reg_model.predict(X_test)
    
    rmse = np.round(np.sqrt(sum( (y_test - y_pred)**2 ) / len(y_test)),3)[0]
        
    return rmse


file = 'hw1_q3_forecasting data.csv'
prediction_horizon=24

linear_regression_RMSE = run_forecasting_linear_regression(file, prediction_horizon=24)
print(linear_regression_RMSE)
