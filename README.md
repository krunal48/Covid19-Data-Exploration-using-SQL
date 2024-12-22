# Covid19-Data-Exploration

## Project Title
Covid-Data-Exploration: Analyzing and Visualizing Global Covid Data

## Introduction
This project focuses on exploring and visualizing Covid-19 data using SQL and Tableau. The aim is to uncover meaningful insights from the data, such as trends in Covid cases, deaths, and vaccination rates across different countries and regions. By performing SQL queries and creating interactive dashboards in Tableau, this project provides an efficient way to understand the impact of Covid-19 and make data-driven decisions.

The dataset used for this project is sourced from [Our World in Data](https://ourworldindata.org/covid-deaths), which provides up-to-date information on Covid-19 statistics globally.

## Installation
### Prerequisites
- Postgre SQL Server (for SQL database software)
- Tableau Desktop (for data visualization)

### Setup Instructions
1. Download the dataset from the following link: [Our World in Data Covid Deaths Dataset](https://ourworldindata.org/covid-deaths).
2. Import the dataset into your PostgreSQL server after creating tables with appropriate datatype for each column and  using the import tools provided by your database software.
3. Open Tableau Desktop and connect it to your SQL database.
4. Follow the instructions in the `Usage` section to execute SQL queries and visualize data.

## Usage
### SQL Data Exploration
1. Import the dataset into your SQL database.
2. Run the following SQL queries to explore the data:
   - Find the top 10 countries with the highest Covid-19 death rates:
     ```sql
     SELECT location, MAX(total_deaths) AS max_deaths
     FROM covid_data
     GROUP BY location
     ORDER BY max_deaths DESC
     LIMIT 10;
     ```
   - Analyze daily new cases trend:
     ```sql
     SELECT date, SUM(new_cases) AS daily_cases
     FROM covid_data
     GROUP BY date
     ORDER BY date;
     ```
   - Calculate vaccination rate by country:
     ```sql
     SELECT location, MAX(people_vaccinated) / population AS vaccination_rate
     FROM covid_data
     WHERE population IS NOT NULL
     GROUP BY location, population
     ORDER BY vaccination_rate DESC;
     ```
## SQL Query Skills Demonstrated
#### 1. Basic SQL Operations
- Creating Tables: CREATE TABLE CovidDeaths, CREATE TABLE CovidVaccinations.
- Dropping Tables: DROP TABLE CovidDeaths, DROP TABLE CovidVaccinations.
- Altering Tables: ALTER TABLE CovidDeaths ALTER COLUMN date TYPE DATE.

#### 2. Data Retrieval
- Selecting Data: SELECT queries to retrieve data from tables.
- Filtering Data: Using WHERE clauses (e.g., WHERE continent IS NOT NULL).
- Sorting Data: Using ORDER BY (e.g., ORDER BY 1, 2).

#### 3. Data Manipulation
- Inserting Data: INSERT INTO PercentPopulationVaccinated.
- Updating Data: Implicit through ALTER TABLE or calculated fields.

#### 4. Aggregations and Grouping
- Aggregating Data: SUM, MAX, AVG, etc., (e.g., SUM(new_cases), MAX(total_deaths)).
- Grouping Data: Using GROUP BY (e.g., GROUP BY Location).

#### 5. Window Functions
- Calculations Over Partitions: SUM(...) OVER (PARTITION BY ...).

#### 6. Joins
- Inner Join: Joining CovidDeaths and CovidVaccinations tables (e.g., ON dea.location = vac.location).

#### 7. Common Table Expressions (CTEs)
- Using WITH clause for intermediate calculations (e.g., WITH PopvsVac).

#### 8. Views
- Creating Views: CREATE VIEW PercentPopulationVaccinated2.

#### 9. Temporary Tables
- Creating Temporary Tables: CREATE TABLE PercentPopulationVaccinated.
- Dropping Temporary Tables: DROP TABLE IF EXISTS PercentPopulationVaccinated.

#### 10. Derived and Calculated Fields
- Creating calculated fields in SELECT queries (e.g., (total_deaths/total_cases)*100 as DeathPercentage).

#### 11. Data Type Casting
- Explicit Casting: Using CAST(... AS type) (e.g., CAST(Total_deaths AS int)).
#### 12. Limiting Results
- Using LIMIT to restrict the number of rows returned (e.g., LIMIT 10).

#### 13. Condition-Based Queries
- Using conditional logic within queries (e.g., WHERE location LIKE '%India%').

#### 14. Date Handling
- Changing data type to DATE and formatting using TO_DATE.

#### 15. Global and Regional Analysis
- Aggregating data at a global or continental level (e.g., GROUP BY continent).

#### 16. Statistical Analysis
- Calculating ratios and percentages (e.g., (total_deaths/total_cases)*100, (RollingPeopleVaccinated/Population)*100).

## Tableau Visualization
1. Use Tableau to connect to your SQL database.
2. Create visualizations such as:
   - Line charts to show trends in daily cases and deaths.
   - Bar charts to compare vaccination rates across countries.
   - Geo maps to visualize the spread of Covid-19 globally.
3. Save your Tableau workbook and share it as a packaged workbook (.twbx) or publish it to Tableau Public.

## Contributing
We welcome contributions to this project! To contribute:
1. Fork the repository and clone it to your local machine.
2. Create a new branch for your feature or bug fix:
   ```
   git checkout -b feature-name
   ```
3. Make your changes and commit them with descriptive messages.
4. Push your branch to your forked repository:
   ```
   git push origin feature-name
   ```
5. Open a pull request and describe the changes you made.

### Reporting Issues
If you encounter bugs or have feature requests, please open an issue in the repository with detailed information and steps to reproduce.

---
Feel free to contact me if you have any questions or suggestions about this project!
