# ST 558 Final Project

This repository contains my final project for ST 558: Data Science for Statisticians.

For this project, I used the Melbourne Housing dataset to predict house prices using different property features. I compared two models to see which one gave better predictions.

## Data and Modeling

The response variable is **Price**.

I used the following predictors:

- Rooms
- Type
- Distance
- Bathroom
- Car
- Landsize
- Regionname

I split the data into 70% training and 30% testing. I used 5-fold cross-validation to tune the models.

I compared two models:

- Regression Tree
- Random Forest

## Model Results

The random forest gave better results than the regression tree, with a lower RMSE and a higher R-squared value. So I selected it as my final model.

The final random forest used 500 trees, with `mtry = 4` and `min_n = 20`.

## Modeling Report

The complete modeling report is available here:

https://lasyaharini-cloud.github.io/ST558_Final_Project/modeling.html

## Prediction API

I created a Plumber API using the final random forest model.

The API has two endpoints:

- `/info` – Gives information about the model.
- `/predict` – Predicts the house price based on the property details entered.

Example prediction:

```text
http://localhost:8000/predict?Rooms=3&Type=h&Distance=10.5&Bathroom=2&Car=2&Landsize=500&Regionname=Southern%20Metropolitan
```

## Docker

I also created a Docker image to run the prediction API. The API can be tested using the Swagger documentation at `http://localhost:8000/__docs__/` when the container is running.
