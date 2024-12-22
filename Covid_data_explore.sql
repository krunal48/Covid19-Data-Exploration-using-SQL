create table CovidDeaths(
iso_code varchar(20),	
continent varchar(20),
location varchar(50),
date varchar(20),
population float,
total_cases int,
new_cases int,	
new_cases_smoothed FLOAT, 
total_deaths int,
new_deaths int,
new_deaths_smoothed	FLOAT,
total_cases_per_million FLOAT,
new_cases_per_million FLOAT, 
new_cases_smoothed_per_million FLOAT,
total_deaths_per_million FLOAT,
new_deaths_per_million float,
new_deaths_smoothed_per_million float,
reproduction_rate float,
icu_patients int,	
icu_patients_per_million float,
hosp_patients int,
hosp_patients_per_million float,
weekly_icu_admissions float,	
weekly_icu_admissions_per_million float,
weekly_hosp_admissions float,
weekly_hosp_admissions_per_million float);

drop table CovidDeaths;

create table CovidVaccinations(
iso_code varchar(20),	
continent varchar(20),
location varchar(50),
date varchar(20),
new_tests int, 
total_tests int, 
total_tests_per_thousand float,
new_tests_per_thousand float,
new_tests_smoothed int,
new_tests_smoothed_per_thousand float,
positive_rate float,
tests_per_case float,
tests_units varchar(50),
total_vaccinations int,
people_vaccinated int,
people_fully_vaccinated int,
new_vaccinations int,
new_vaccinations_smoothed int,
total_vaccinations_per_hundred float,
people_vaccinated_per_hundred float,
people_fully_vaccinated_per_hundred float,
new_vaccinations_smoothed_per_million int,
stringency_index float,
population_density float,
median_age float,
aged_65_older float,
aged_70_older float,
gdp_per_capita float,
extreme_poverty float,
cardiovasc_death_rate float,
diabetes_prevalence float,
female_smokers float,
male_smokers float,
handwashing_facilities float,
hospital_beds_per_thousand float,
life_expectancy float,
human_development_index float);

drop table CovidVaccinations;

show datestyle;

select * from CovidDeaths;

select * from CovidVaccinations;

ALTER TABLE CovidDeaths ALTER COLUMN date TYPE DATE 
using to_date(date, 'DD/MM/YYYY');

ALTER TABLE CovidVaccinations ALTER COLUMN date TYPE DATE 
using to_date(date, 'DD/MM/YYYY');

Select *
From CovidDeaths
Where continent is not null 
order by 3,4;

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From CovidDeaths
Where continent is not null 
order by 1,2;

-- Total Cases vs Total Deaths
-- by which we can identify the likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
Where location like '%India%'
and continent is not null 
order by 1,2;

Select Location, date, Population, total_cases, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths
order by 1,2;

Select f.Location, f.Population, t.max_cases, t.max_deaths
from(
	select Location, max(total_cases) as max_cases, max(total_deaths) as max_deaths
	from CovidDeaths
	group by Location
) t join CovidDeaths f on f.Location = t.Location and t.max_cases = f.total_cases and t.max_deaths = f.total_deaths;

select Location, max(Population) as population, max(total_cases) as cases, max(total_deaths) as deaths
from CovidDeaths
group by Location
order by 1;

select Location, population, cases, deaths, (deaths*100/cases) as DeathPercentage
from (
	select Location, max(Population) as population, max(total_cases) as cases, max(total_deaths) as deaths
	from CovidDeaths
	group by Location
)
order by 1;

-- Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc;

-- Countries with Highest Death Count per Population

Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
--Where location like '%states%'
Where continent is not null  and Total_deaths is not null
Group by Location
order by TotalDeathCount desc;

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidDeaths
--Where location like '%states%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc;

-- GLOBAL NUMBERS

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as float))/SUM(New_Cases)*100 as DeathPercentage
From CovidDeaths
--Where location like '%India%'
where continent is not null 
--Group By date
order by 1,2;


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3;


-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac;

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists PercentPopulationVaccinated;

Create Table PercentPopulationVaccinated
(
Continent varchar(255),
Location varchar(255),
Date date,
Population float,
New_vaccinations float,
RollingPeopleVaccinated float
);

Insert into PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date;
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100 as RecentVaccinatedPerc
From PercentPopulationVaccinated;


-- Creating View to store data for later visualizations

Create View PercentPopulationVaccinated2 as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CAST(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From CovidDeaths dea
Join CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null;
