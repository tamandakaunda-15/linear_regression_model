# Machine Learning Project: Medical Cost and Diabetes Prediction

Thought for 1 second## Compelling Problem Statement & Target Stakeholders

This repository contains a comprehensive machine learning project that includes:
1. A linear regression model for predicting medical insurance costs
2. A FastAPI application for diabetes prediction
3. A Flutter mobile app that connects to the API(MediCost Predictor)

### Problem Statement

Medical insurance costs in the United States have been rising steadily, with premiums increasing by 47% over the last decade. Many individuals and families struggle to anticipate these costs when budgeting for healthcare expenses, leading to financial strain and potential avoidance of necessary medical care. The lack of transparency and predictability in insurance pricing creates significant challenges for consumers trying to make informed financial decisions about their healthcare coverage.

MediCost Predictor addresses this critical gap by providing accurate, personalized insurance cost estimates based on key demographic and health factors. By leveraging machine learning algorithms trained on real insurance data, our application empowers users with the information they need to plan effectively for healthcare expenses, compare different insurance scenarios, and make data-driven decisions about their coverage options.

### Target Stakeholders

1. **Individual Insurance Seekers**

1. Young adults transitioning to independent healthcare coverage
2. Self-employed professionals managing their own insurance
3. People experiencing life changes (marriage, relocation, career shifts) that affect insurance needs
4. Individuals approaching retirement and planning for Medicare supplements



2. **Families**

1. Parents planning for family healthcare expenses
2. Families considering adding dependents to their insurance
3. Households evaluating the financial impact of lifestyle changes (e.g., smoking cessation)



3. **Financial Planners & Advisors**

1. Financial advisors helping clients budget for healthcare costs
2. Retirement planners incorporating healthcare expenses into long-term financial plans
3. Wealth managers optimizing client portfolios with healthcare considerations



4. **Healthcare Providers**

1. Medical practices helping patients understand potential costs
2. Healthcare administrators advising patients on financial planning
3. Patient advocates working to improve financial literacy around healthcare



5. **Insurance Brokers & Agents**

1. Insurance professionals providing quick estimates to potential clients
2. Brokers comparing different insurance scenarios for customers
3. Agents demonstrating the impact of lifestyle factors on premiums


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

### Request Format for Diabetes Prediction:
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
- **Machine Learning**: Scikit-learn (RandomForestClassifier, Linear Regression)
- **Backend**: FastAPI
- **Frontend**: Flutter
- **Deployment**: Uvicorn (ASGI server), Heroku/Custom Deployment (your choice)




## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments
- Thanks to [FastAPI](https://fastapi.tiangolo.com/) for providing a fast and easy framework for API development.
- Thanks to [Flutter](https://flutter.dev/) for enabling cross-platform mobile app development.

