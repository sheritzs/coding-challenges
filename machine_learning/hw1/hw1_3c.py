"""
Implement an LSTM model to perform the multistep forecasting. You can freely choose the number of layers, hidden
units, and other hyperparameters of the LSTM model (though a single hidden layer LSTM with few hidden units, e.g., 8,
trained over a large number of epochs is recommended.
"""


import warnings
warnings.filterwarnings('ignore') 

import pandas as pd
import numpy as np
import random
import time
from keras.models import Sequential
from keras.layers import Dense, LSTM
from keras.metrics import RootMeanSquaredError

lookback_window = 2 * 24 # use 2 previous days' worth of data 

def lstm_model(prediction_horizon, lookback_window=lookback_window, n_features=1):
    model = Sequential()
    model.add(LSTM(12, activation='relu', 
                   input_shape=(lookback_window, n_features)))
    model.add(Dense(6, activation='leaky_relu'))
    model.add(Dense(prediction_horizon))
    model.compile(optimizer='adam', loss='mse', 
                  metrics=[RootMeanSquaredError()])
    return model

def get_rmse(y_actual, y_pred):
    return np.round(np.sqrt(sum( (y_actual - y_pred)**2 ) / len(y_actual)),3)[0]

def split_series(time_series, n_input_steps, n_output_steps):
    X, y = list(), list()
    
    for idx, _ in enumerate(time_series):
        
        # determine the end of the pattern
        end_idx = idx + n_input_steps
        out_end_idx = end_idx + n_output_steps
        
        # avoid going out of bounds
        if out_end_idx > len(time_series):
            break
            
        # get the inputs and outputs in an autoregressive manner
        seq_x, seq_y = time_series[idx:end_idx], time_series[end_idx:out_end_idx]
        X.append(seq_x)
        y.append(seq_y)
        
    X = np.array(X)
    y = np.array(y)

    return X,  y

def run_forecasting_LSTM(file, prediction_horizon):
    df = pd.read_csv(file, index_col='datetime')
    n_features = df.shape[1]

    X_train = df['MT_1'].values[:-prediction_horizon]
    X_test = df['MT_1'].values[-(lookback_window + prediction_horizon):-prediction_horizon]
    y_test = df['MT_1'].values[-prediction_horizon:]

    # normalize the dataset using Xtrain mean & std to avoid data leakage
    Xtrain_mean = X_train.mean()
    Xtrain_std = X_train.std()
    X_train_normalized = (X_train - Xtrain_mean) / Xtrain_std 
    X_test_normalized = (X_test - Xtrain_mean) / Xtrain_std 


    X_train_normalized, y_train_normalized = split_series(X_train_normalized, 
                                n_input_steps=lookback_window, 
                                n_output_steps=prediction_horizon)

    X_train_normalized = X_train_normalized.reshape((X_train_normalized.shape[0], X_train_normalized.shape[1], n_features))


    model = lstm_model(prediction_horizon, lookback_window, n_features)

    start_time = time.perf_counter()
    model.fit( X_train_normalized, y_train_normalized, epochs=200, verbose=2)
    end_time = time.perf_counter()
    total_training_time = (end_time - start_time)/3600
    print(f'Total Training time: {total_training_time:.1f} hours')

    X_test_normalized = X_test_normalized.reshape((1, lookback_window, n_features))
    y_pred_normalized = model.predict(X_test_normalized, verbose=0)

    # convert back to original units
    y_pred = (y_pred_normalized * Xtrain_std) + Xtrain_mean

    rmse = round(get_rmse(y_test, y_pred),3)
    
    return rmse

