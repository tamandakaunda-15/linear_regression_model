# Machine Learning Project: Medical Cost and Diabetes Prediction

This repository contains a comprehensive machine learning project that includes:
1. A linear regression model for predicting medical insurance costs
2. A FastAPI application for diabetes prediction
3. A Flutter mobile app that connects to the API

## API Endpoint

The API is hosted locally and can be accessed at:
- Base URL: [https://prediction-a28a.onrender.com/](https://prediction-a28a.onrender.com/)
- Swagger UI Documentation: [https://prediction-a28a.onrender.com/docs](https://prediction-a28a.onrender.com/docs)

### Request Format for Diabetes Prediction:
- Endpoint: `/predict`
- Method: `POST`
- Request Body:

    ```json
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
    ```

### Response Format:
- Example Response:

    ```json
    {
        "prediction": 1,
        "probability": 0.85,
        "message": "The patient is likely to have diabetes."
    }
    ```

## Video Demo

Watch the demo video here: [YouTube Link](https://youtu.be/your-video-id)

## Project Structure

```
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
```

## Installation

### FastAPI Setup
1. Clone the repository:
    ```bash
    git clone https://github.com/tamandakaunda-15/linear_regression_model.git
    cd linear_regression_model/summative/API
    ```

2. Create a virtual environment:
    ```bash
    python -m venv venv
    source venv/bin/activate  #  use `venv\Scripts\activate` for windows
    ```

3. Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

4. Run the FastAPI server:

    ```bash
    uvicorn app:app --reload
    ```

### Flutter App Setup
1. Clone the repository:

    ```bash
    git clone  https://github.com/tamandakaunda-15/linear_regression_model.git
    cd linear_regression_model/diabetes_prediction_app
    ```

2. Install Flutter dependencies:

    ```bash
    flutter pub get
    ```

3. Run the Flutter app on an emulator or device:

    ```bash
    flutter run
    ```

## Technologies Used
- **Machine Learning**: Scikit-learn (RandomForestClassifier, Linear Regression)
- **Backend**: FastAPI
- **Frontend**: Flutter
- **Deployment**: Uvicorn (ASGI server), Heroku/Custom Deployment (your choice)

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- Thanks to [FastAPI](https://fastapi.tiangolo.com/) for providing a fast and easy framework for API development.
- Thanks to [Flutter](https://flutter.dev/) for enabling cross-platform mobile app development.

