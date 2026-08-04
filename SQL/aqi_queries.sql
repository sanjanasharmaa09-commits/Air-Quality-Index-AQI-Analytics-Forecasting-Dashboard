DROP DATABASE IF EXISTS aqi_project;
CREATE DATABASE aqi_project;
USE aqi_project;

CREATE TABLE city_day (
    City VARCHAR(50),
    Date DATE,
    `PM2.5` FLOAT NULL,
    PM10 FLOAT NULL,
    NO FLOAT NULL,
    NO2 FLOAT NULL,
    NOx FLOAT NULL,
    NH3 FLOAT NULL,
    CO FLOAT NULL,
    SO2 FLOAT NULL,
    O3 FLOAT NULL,
    Benzene FLOAT NULL,
    Toluene FLOAT NULL,
    Xylene FLOAT NULL,
    AQI INT NULL,
    AQI_Bucket VARCHAR(20) NULL
);

SET GLOBAL sql_mode = REPLACE(@@GLOBAL.sql_mode, 'STRICT_TRANS_TABLES', '');
SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'city_day.csv'
INTO TABLE city_day
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(City, @Date, @PM25, @PM10, @NO, @NO2, @NOx, @NH3, @CO, @SO2, @O3, @Benzene, @Toluene, @Xylene, @AQI, @AQI_Bucket)
SET
  Date = NULLIF(@Date, ''),
  `PM2.5` = NULLIF(@PM25, ''),
  PM10 = NULLIF(@PM10, ''),
  NO = NULLIF(@NO, ''),
  NO2 = NULLIF(@NO2, ''),
  NOx = NULLIF(@NOx, ''),
  NH3 = NULLIF(@NH3, ''),
  CO = NULLIF(@CO, ''),
  SO2 = NULLIF(@SO2, ''),
  O3 = NULLIF(@O3, ''),
  Benzene = NULLIF(@Benzene, ''),
  Toluene = NULLIF(@Toluene, ''),
  Xylene = NULLIF(@Xylene, ''),
  AQI = NULLIF(@AQI, ''),
  AQI_Bucket = NULLIF(@AQI_Bucket, '');
  
 USE aqi_project;
LOAD DATA LOCAL INFILE 'D:/SUBJECTS/Data_Analyst/AnalystProjects/AQI_Analysis/city_day.csv'
INTO TABLE city_day
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(City, @Date, @PM25, @PM10, @NO, @NO2, @NOx, @NH3, @CO, @SO2, @O3, @Benzene, @Toluene, @Xylene, @AQI, @AQI_Bucket)
SET
  Date = NULLIF(@Date, ''),
  `PM2.5` = NULLIF(@PM25, ''),
  PM10 = NULLIF(@PM10, ''),
  NO = NULLIF(@NO, ''),
  NO2 = NULLIF(@NO2, ''),
  NOx = NULLIF(@NOx, ''),
  NH3 = NULLIF(@NH3, ''),
  CO = NULLIF(@CO, ''),
  SO2 = NULLIF(@SO2, ''),
  O3 = NULLIF(@O3, ''),
  Benzene = NULLIF(@Benzene, ''),
  Toluene = NULLIF(@Toluene, ''),
  Xylene = NULLIF(@Xylene, ''),
  AQI = NULLIF(@AQI, ''),
  AQI_Bucket = NULLIF(@AQI_Bucket, '');
  
SELECT COUNT(*) FROM city_day;

SELECT * FROM city_day LIMIT 10;

SELECT DISTINCT City FROM city_day;


-- 1. Yearly average AQI per city
SELECT City, YEAR(Date) AS Yr, ROUND(AVG(AQI),1) AS Avg_AQI
FROM city_day
WHERE AQI IS NOT NULL
GROUP BY City, YEAR(Date)
ORDER BY City, Yr;

-- 2. Worst month per city (highest avg AQI)
SELECT City, MONTH(Date) AS Mnth, ROUND(AVG(AQI),1) AS Avg_AQI
FROM city_day
WHERE AQI IS NOT NULL
GROUP BY City, MONTH(Date)
ORDER BY City, Avg_AQI DESC;

-- 3. Most polluted city overall
SELECT City, ROUND(AVG(AQI),1) AS Avg_AQI
FROM city_day
WHERE AQI IS NOT NULL
GROUP BY City
ORDER BY Avg_AQI DESC;

-- 4. AQI category distribution per city (kitne din "Severe" the etc.)
SELECT City, AQI_Bucket, COUNT(*) AS Days
FROM city_day
WHERE AQI_Bucket IS NOT NULL
GROUP BY City, AQI_Bucket
ORDER BY City, Days DESC;

-- 5. Year-over-year trend — improving ya worsening?
SELECT City, YEAR(Date) AS Yr, ROUND(AVG(AQI),1) AS Avg_AQI,
       ROUND(AVG(AQI),1) - LAG(ROUND(AVG(AQI),1)) OVER (PARTITION BY City ORDER BY YEAR(Date)) AS Change_From_Prev_Year
FROM city_day
WHERE AQI IS NOT NULL
GROUP BY City, YEAR(Date)
ORDER BY City, Yr;

SET SQL_SAFE_UPDATES = 0;
UPDATE city_day SET `PM2.5` = NULL WHERE `PM2.5` = 0;
SET SQL_SAFE_UPDATES = 1;   -- wapas ON kar do, safety ke liye

SELECT * FROM city_day;
