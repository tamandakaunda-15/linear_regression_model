from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, validator 
from pydantic import BaseModel, field_validator
import joblib
import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import uvicorn

# Create FastAPI app
app = FastAPI(title="Diabetes Prediction API",
              description="API for predicting diabetes based on medical data",
              version="1.0.0")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

# Define input data model with constraints
class DiabetesInput(BaseModel):
    pregnancies: int = Field(..., ge=0, le=20, description="Number of pregnancies")
    glucose: float = Field(..., ge=0, le=300, description="Glucose level")
    blood_pressure: float = Field(..., ge=0, le=200, description="Blood pressure")
    skin_thickness: float = Field(..., ge=0, le=100, description="Skin thickness")
    insulin: float = Field(..., ge=0, le=1000, description="Insulin level")
    bmi: float = Field(..., ge=0, le=70, description="Body Mass Index")
    diabetes_pedigree: float = Field(..., ge=0, le=3, description="Diabetes pedigree function")
    age: int = Field(..., ge=0, le=120, description="Age in years")
    
    # Additional validators
    @field_validator('pregnancies')
    def pregnancies_must_be_realistic(cls, v):
        if v > 15:
            raise ValueError('Number of pregnancies seems unrealistically high')
        return v
    
    @field_validator('glucose')
    def glucose_must_be_realistic(cls, v):
        if v < 40:
            raise ValueError('Glucose level is too low to be realistic')
        return v

# Define prediction response model
class DiabetesPrediction(BaseModel):
    prediction: int
    probability: float
    message: str

# Load and train the model
def train_model():
    # Load the diabetes dataset
    url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv"
    column_names = ['pregnancies', 'glucose', 'blood_pressure', 'skin_thickness', 
                    'insulin', 'bmi', 'diabetes_pedigree', 'age', 'outcome']
    dataset = pd.read_csv(url, names=column_names)
    
    # Split features and target
    X = dataset.iloc[:, :-1]
    y = dataset.iloc[:, -1]
    
    # Split data into training and testing sets
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    # Scale the features
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    
    # Train a Random Forest model
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train_scaled, y_train)
    
    return model, scaler

# Train the model and get the scaler
model, scaler = train_model()

# Define prediction endpoint
@app.post("/predict", response_model=DiabetesPrediction)
def predict(data: DiabetesInput):
    try:
        # Convert input data to numpy array
        input_data = np.array([
            [
                data.pregnancies,
                data.glucose,
                data.blood_pressure,
                data.skin_thickness,
                data.insulin,
                data.bmi,
                data.diabetes_pedigree,
                data.age
            ]
        ])
        
        # Scale the input data
        input_data_scaled = scaler.transform(input_data)
        
        # Make prediction
        prediction = model.predict(input_data_scaled)[0]
        probability = model.predict_proba(input_data_scaled)[0][1]
        
        # Create response message
        if prediction == 1:
            message = "The patient is likely to have diabetes."
        else:
            message = "The patient is unlikely to have diabetes."
        
        return DiabetesPrediction(
            prediction=int(prediction),
            probability=float(probability),
            message=message
        )
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Root endpoint
@app.get("/")
def read_root():
    return {"message": "Welcome to the Diabetes Prediction API. Go to /docs for the Swagger UI."}

# Run the application
if __name__ == "__main__":
    uvicorn.run("prediction:app", host="0.0.0.0", port=8000, reload=True)