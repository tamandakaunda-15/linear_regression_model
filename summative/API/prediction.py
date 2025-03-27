from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, validator
import joblib
import numpy as np
import pandas as pd
import uvicorn
import os

# Create FastAPI app
app = FastAPI(title="Insurance Cost Prediction API",
              description="API for predicting medical insurance costs",
              version="1.0.0")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Define input data model with constraints
class InsuranceInput(BaseModel):
    age: int = Field(..., ge=18, le=100, description="Age in years")
    sex: str = Field(..., description="Gender (male/female)")
    bmi: float = Field(..., ge=10, le=50, description="Body Mass Index")
    children: int = Field(..., ge=0, le=10, description="Number of children/dependents")
    smoker: str = Field(..., description="Smoking status (yes/no)")
    region: str = Field(..., description="Region (northeast/northwest/southeast/southwest)")
    
    # Validators
    @validator('sex')
    def sex_must_be_valid(cls, v):
        if v.lower() not in ['male', 'female']:
            raise ValueError('Sex must be either male or female')
        return v.lower()
    
    @validator('smoker')
    def smoker_must_be_valid(cls, v):
        if v.lower() not in ['yes', 'no']:
            raise ValueError('Smoker must be either yes or no')
        return v.lower()
    
    @validator('region')
    def region_must_be_valid(cls, v):
        valid_regions = ['northeast', 'northwest', 'southeast', 'southwest']
        if v.lower() not in valid_regions:
            raise ValueError(f'Region must be one of: {", ".join(valid_regions)}')
        return v.lower()

# Define prediction response model
class InsurancePrediction(BaseModel):
    predicted_cost: float
    message: str

# Get the absolute path of the directory
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SCALER_PATH = os.path.join(BASE_DIR, "../linear_regression/scaler.pkl")
MODEL_PATH = os.path.join(BASE_DIR, "../linear_regression/best_model.pkl")

# Load the model and scaler
try:
    print(f"Current Working Directory: {os.getcwd()}")
    print(f"Loading scaler from: {SCALER_PATH}")
    print(f"Loading model from: {MODEL_PATH}")

    # Load the scaler
    scaler = joblib.load(SCALER_PATH)
    
    # Load the model
    model = joblib.load(MODEL_PATH)
    
    print("Model and scaler loaded successfully")
except Exception as e:
    print(f"Error loading model or scaler: {e}")

# Define the expected columns (feature names)
expected_columns = ['age', 'bmi', 'children', 'sex_male', 'smoker_yes', 
                   'region_northwest', 'region_southeast', 'region_southwest']

# Define prediction endpoint
@app.post("/predict", response_model=InsurancePrediction)
def predict(data: InsuranceInput):
    try:
        # Create a dataframe with the input values
        input_data = {
            'age': [data.age],
            'bmi': [data.bmi],
            'children': [data.children]
        }
        
        # Add dummy variables
        input_data['sex_male'] = [1 if data.sex == 'male' else 0]
        input_data['smoker_yes'] = [1 if data.smoker == 'yes' else 0]
        
        # Region dummies
        input_data['region_northwest'] = [1 if data.region == 'northwest' else 0]
        input_data['region_southeast'] = [1 if data.region == 'southeast' else 0]
        input_data['region_southwest'] = [1 if data.region == 'southwest' else 0]
        
        # Create dataframe
        df = pd.DataFrame(input_data)
        
        # Ensure columns are in the same order as during training
        for col in expected_columns:
            if col not in df.columns:
                df[col] = 0
        df = df[expected_columns]
        
        # Scale the features
        df_scaled = scaler.transform(df)
        
        # Make prediction
        prediction = model.predict(df_scaled)[0]
        
        return InsurancePrediction(
            predicted_cost=float(prediction),
            message=f"The estimated insurance cost is ${prediction:.2f}"
        )
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to the Insurance Cost Prediction API. Go to /docs for the Swagger UI."}

# Run the application
if __name__ == "__main__":
    uvicorn.run("prediction:app", host="127.0.0.1", port=8001, reload=True)
