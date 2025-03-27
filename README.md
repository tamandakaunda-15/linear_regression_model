# Machine Learning Project: Medical Cost and Diabetes Prediction

This repository contains a comprehensive machine learning project that includes:
1. A linear regression model for predicting medical insurance costs
2. A FastAPI application for diabetes prediction
3. A Flutter mobile app that connects to the API(MediCost Predictor)

#### Problem Statement 

While our model is trained on US healthcare data, the underlying problem of predicting and understanding medical costs is universal. Healthcare affordability is a global challenge, with the World Health Organization reporting that over 800 million people spend at least 10% of their household budget on healthcare expenses. Our application demonstrates how machine learning can bring transparency to healthcare costs—a concept applicable across different healthcare systems worldwide.

#### Target Stakeholders

 **Healthcare Policymakers**

1. Government officials designing healthcare financing systems
2. Public health administrators allocating resources
3. International development organizations working on healthcare access


 **Healthcare Researchers**

1. Academics studying healthcare economics across different systems
2. Researchers comparing cost factors between countries
3. Data scientists developing predictive models for healthcare


 **Global Health Organizations**

1. NGOs working on healthcare affordability
2. International agencies developing healthcare financing solutions
3. Cross-border healthcare providers

 **Educational Institutions**

1. Medical schools teaching healthcare economics
2. Public health programs studying cost prediction models
3. Data science programs exploring healthcare applications

### Value Proposition

MediCost Predictor delivers value through:

- **Accuracy**: Leveraging advanced machine learning models trained on comprehensive datasets
- **Accessibility**: Providing instant estimates without complex paperwork or consultations
- **Education**: Helping users understand the factors that influence their insurance costs
- **Empowerment**: Enabling informed decision-making about healthcare and lifestyle choices
- **Planning**: Supporting better financial planning and budgeting for healthcare expenses



## API Endpoint

The API is hosted locally and can be accessed at:
- Base URL: [https://medical-insurance-predictor-44bt.onrender.com/](https://medical-insurance-predictor-44bt.onrender.com/)
- Swagger UI Documentation: [https://medical-insurance-predictor-44bt.onrender.com/docs](https://medical-insurance-predictor-44bt.onrender.com/docs)

### Request Format for Medical Insurance Prediction:
- Endpoint: `/predict`
- Method: `POST`
- Request Body:

    ```json
    
       {
  "age": 25,
  "sex": "female",
  "bmi": 20,
  "children": 1,
  "smoker": "yes",
  "region": "southwest"
       }   
    ```

### Response Format:
- Example Response:

    ```json
    {
      "predicted_cost": 15473.500462400007,
      "message": "The estimated insurance cost is $15473.50"
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
├── insurance_cost_predictor_app
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
    cd linear_regression_model/insurance_cost_predictor
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
- **Machine Learning**: Scikit-learn (RandomForestClassifier, Linear Regression), Seaborn, Matplotli
- **Backend**: FastAPI (Python)
- **Frontend**: Flutter
- **Deployment**: Uvicorn (ASGI server), Render(for fastAPI deployment)




## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- Thanks to [FastAPI](https://fastapi.tiangolo.com/) for providing a fast and easy framework for API development.
- Thanks to [Flutter](https://flutter.dev/) for enabling cross-platform mobile app development.

