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
2. Import the dataset into your SQL database using the import tools provided by your database software.
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

### Tableau Visualization
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
