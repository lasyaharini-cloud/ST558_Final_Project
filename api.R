library(plumber)
library(tidymodels)

# Load saved model
rf_model <- readRDS("models/random_forest_model.rds")

#* Get information about the API
#* @get /info
function() {
  list(
    project = "Melbourne Housing Price Prediction",
    model = "Random Forest",
    description = "Predicts house prices using property information",
    currency = "AUD"
  )
}

#* Predict Melbourne house price
#* @param Rooms Number of rooms
#* @param Type Property type (h, t, or u)
#* @param Distance Distance from city center
#* @param Bathroom Number of bathrooms
#* @param Car Number of car spaces
#* @param Landsize Land size in square meters
#* @param Regionname Region of Melbourne
#* @get /predict
function(Rooms, Type, Distance, Bathroom, Car, Landsize, Regionname) {
  
  # Create a data frame using the inputs
  new_house <- data.frame(
    Rooms = as.numeric(Rooms),
    Type = Type,
    Distance = as.numeric(Distance),
    Bathroom = as.numeric(Bathroom),
    Car = as.numeric(Car),
    Landsize = as.numeric(Landsize),
    Regionname = Regionname
  )
  
  # Predict the house price
  predicted_price <- predict(rf_model, new_data = new_house)
  
  # Return the prediction
  list(
    predicted_price = round(predicted_price$.pred, 2),
    currency = "AUD"
  )
}