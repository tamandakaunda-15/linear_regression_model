# Machine Learning Project: Medical Cost and Diabetes Prediction

This repository contains a comprehensive machine learning project that includes:

A linear regression model for predicting medical insurance costs

A FastAPI application for diabetes prediction

A Flutter mobile app that connects to the API

# API Endpoint

The API is hosted locally and can be accessed at:

Base URL: http://127.0.0.1:8000/

Swagger UI Documentation: http://127.0.0.1:8000/docs

Request Format for Diabetes Prediction:

Endpoint: /predict

Method: POST

### Request Body:

{
    "pregnancies": 2,
    "glucose": 150,
    "blood_pressure": 80,
    "skin_thickness": 30,
    "insulin": 100,
    "bmi": 28,
    "diabetes_pedigree": 0.5,
    "age": 35
}

### Response Format:

Example Response:

'''{
    "prediction": 1,
    "probability": 0.85,
    "message": "The patient is likely to have diabetes."
} '''

# Video Demo

Watch the demo video here: YouTube Link

### Project Structure

'''
.
├── api
│   ├── app.py             # FastAPI backend implementation
│   ├── model.pkl          # Trained machine learning model
│   ├── requirements.txt   # Python dependencies
├── flutter_app
│   ├── lib
│   │   ├── main.dart      # Flutter app implementation
│   ├── pubspec.yaml       # Flutter dependencies
├── README.md              # Project documentation (this file)

'''

# Installation

## FastAPI Setup

Clone the repository:

git clone https://github.com/tamandakaunda-15/linear_regression_model.git
cd your-repository/api

Create a virtual environment:

''' python -m venv venv
source venv/bin/activate  # For Windows use `venv\Scripts\activate`

Install dependencies:

pip install -r requirements.txt

Run the FastAPI server:

uvicorn app:app --reload

Flutter App Setup

Clone the repository:

git clone https://github.com/tamandakaunda-15/linear_regression_model.git

cd your-repository/flutter_app '''

## Install Flutter dependencies:

''' flutter pub get

Run the Flutter app on an emulator or device:

flutter run '''

## Technologies Used

Machine Learning: Scikit-learn (RandomForestClassifier, Linear Regression)

Backend: FastAPI

Frontend: Flutter

Deployment: Uvicorn (ASGI server), Heroku/Custom Deployment (your choice)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

Thanks to FastAPI for providing a fast and easy framework for API development.

Thanks to Flutter for enabling cross-platform mobile app development.

