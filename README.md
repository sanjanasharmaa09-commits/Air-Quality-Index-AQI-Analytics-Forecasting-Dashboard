# Air Quality Index (AQI) Analytics & Forecasting Dashboard

An end-to-end data analytics project analyzing air quality trends across 10 major Indian cities, combining historical government data with live API integration, SQL analysis, Python-based time-series forecasting, and an interactive Tableau dashboard.

---

## Problem Statement

Air pollution is a critical public health issue in India, with AQI levels varying significantly by city and season. This project analyzes historical air quality data to identify pollution trends, forecast future AQI levels, and translate raw pollutant data into actionable health-risk categories for the public.

---

## Project Overview

| Stage | Tool | Purpose |
|---|---|---|

| Data Collection | CPCB Historical Data (Kaggle) + OpenWeatherMap API | Historical + live AQI data |
| Data Storage & Cleaning | MySQL | Structured queries, trend analysis |
| Analysis & Forecasting | Python (Pandas, Prophet) | Correlation analysis, time-series forecasting |
| Visualization | Tableau Public | Interactive dashboard with health-risk classification |

---

## Data Sources

1. **CPCB Historical Dataset** (via Kaggle "Air Quality Data in India") — daily pollutant and AQI records (2015–2020) for 26+ Indian cities
2. **OpenWeatherMap Air Pollution API** — live pollutant concentration data, converted to CPCB-standard AQI using official sub-index breakpoint formulas

**Cities analyzed:** Delhi, Mumbai, Bengaluru, Kolkata, Bhopal, Lucknow, Chennai, Patna, Hyderabad, Jaipur — selected to represent a range of pollution severity across regions.

---
# Raw dataset (all 26 cities): [Download from Kaggle](https://www.kaggle.com/datasets/rohanrao/air-quality-data-in-india)
## Data Cleaning

- Removed columns with excessive missing data (e.g., Xylene — 61% missing)
- Dropped rows with missing target variable (AQI)
- Applied city-wise linear interpolation for missing pollutant values, with residual gaps filled using column median
- Removed duplicate city-date records
- Final dataset: **13,926 cleaned records** across 10 cities

---

## SQL Analysis (MySQL)

Key queries performed on the cleaned dataset:

- Yearly average AQI per city
- Month-wise worst AQI periods per city
- City-wise AQI category distribution (Good / Moderate / Poor / Severe)
- Year-over-year AQI change using window functions (`LAG()`)
- Most polluted cities ranked by average AQI

**Sample insight:** Ahmedabad recorded 638 days in the "Severe" AQI category — the highest among all analyzed cities.

---

## Python Analysis & Forecasting

**Correlation Analysis**
Identified the dominant pollutant driving AQI in each city (e.g., PM2.5 and PM10 emerged as primary drivers in most cities), using pollutant-AQI correlation matrices.

**Time-Series Forecasting (Facebook Prophet)**
- Built a 3-month AQI forecasting model for Delhi using historical daily data
- Initial daily-level model: **MAE of 52.84** AQI points
- Improved to **MAE of 39.10** AQI points (26% improvement) by aggregating data to weekly granularity, reducing day-to-day volatility noise
- Extracted trend and seasonality components to identify high-pollution periods (winter months)

**Live Data Pipeline**
Built a Python script to fetch live pollutant data via the OpenWeatherMap API and calculate real-time AQI using CPCB's official sub-index formulas (PM2.5, PM10, NO2, SO2, CO, O3), enabling continuous dataset growth through scheduled runs.

---

## Tableau Dashboard

The interactive dashboard includes:

- **India Map View** — color-coded AQI by city (green to red scale)
- **Trend Line Chart** — AQI over time, filterable by city
- **Health Impact Panel** — AQI scores translated into CPCB-official risk categories (Good, Satisfactory, Moderate, Poor, Very Poor, Severe) using a custom calculated field
- Dashboard-wide filters synced across all visuals

**Dashboard link:** *[Add your Tableau Public link here]*

---

## Key Insights

- Ahmedabad and Delhi consistently rank among the most polluted cities, with a high proportion of "Severe" AQI days
- PM2.5 and PM10 are the dominant pollutants driving AQI across most cities
- AQI shows strong seasonal patterns, with winter months consistently worse across northern cities
- Weekly data aggregation significantly improves forecasting accuracy over daily-level modeling

---
## Tech Stack

`SQL (MySQL)` `Python` `Pandas` `Prophet` `Matplotlib/Seaborn` `Tableau Public` `REST API (OpenWeatherMap)`

---

## Project Structure

```
AQI_Analysis/
├── data/
│   ├── Raw dataset  [Download from Kaggle](https://www.kaggle.com/datasets/rohanrao/air-quality-data-in-india)                    # Raw historical dataset
│   ├── aqi_cleaned_for_tableau.csv     # Cleaned dataset used in Tableau
│   ├── live_aqi_data.csv               # Live API-collected data
│   └── delhi_forecast.csv              # Prophet forecast output
├── scripts/
│   └── aqi_api_fetch.py                # Live API data collection script
├── notebooks/
│   └── aqi_analysis.ipynb              # Python analysis & forecasting notebook
├── sql/
│   └── aqi_queries.sql                 # All SQL queries used
└── README.md
```

---

## Future Improvements

- Extend forecasting to all 10 cities with automated model comparison
- Add a real-time alert system for hazardous AQI thresholds
- Incorporate weather data (temperature, humidity) as additional forecasting features

---

## Author

**Sanjana Sharma**
Final-year BCA (AI & Data Science) student
[GitHub](https://github.com/sanjanasharmaa09) 
