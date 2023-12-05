Select *
From PortfolioProject.dbo.CovidDeaths
Where continent is not null
order by 3,4 


--Select *
--From PortfolioProject.dbo.CovidVaccinations
--order by 3,4

--select data we are going to be using 

--Select location, date, total_cases,total_deaths, new_cases, population
--From PortfolioProject.dbo.CovidDeaths
--order by 1,2

--Totalcases vs total deaths
Select location, date, total_cases,total_deaths,(CONVERT(float, total_deaths)/ NULLIF(CONVERT(float, total_cases),0))*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths
Where location like '%states%'
order by 1,2

--looking at Total Cases vs Population 

Select location, date, total_cases, population,(CONVERT(float, total_cases)/ NULLIF(CONVERT(float, population),0))*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths
Where location like '%states%'
and continent is not null
order by 1,2

--Looking at Countries with Highest Infection Rate VS Population 

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX(CONVERT(float, total_cases)/ NULLIF(CONVERT(float, population),0))*100 as PopulationPercentageInfected
From PortfolioProject.dbo.CovidDeaths
Where location like '%states%'
Group by Location, population 
order by 1,2


Select location, population, MAX(total_cases) as HighestInfectionCount, MAX(CONVERT(float, total_cases)/ NULLIF(CONVERT(float, population),0))*100 as PercentagePopulationInfected
From PortfolioProject.dbo.CovidDeaths
Where location like '%states%'
Group by Location, population 
order by PercentagePopulationInfected desc

--Countries With Highest Death Count per Population

select location, MAX(CAST(total_deaths as int)) as TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
--Where location like '%states%'
Where continent is null
Group by Location, population
order by TotalDeathCount desc

--BY Continent 
 select continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
From PortfolioProject.dbo.CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by continent
order by TotalDeathCount desc

--continent with highest death count per population

--select Continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
--From PortfolioProject.dbo.CovidDeaths
----Where location like '%states%'
--Where continent is  not null
--Group by  population
--order by TotalDeathCount desc

--GLOBAL NUMBERS
select date, SUM(new_cases), SUM(new_deaths), SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject.dbo.CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by  date
order by 1, 2

--JOINS 

select *
From PortfolioProject.dbo.CovidDeaths deat
Join PortfolioProject.dbo.CovidVaccinations vacc
	On deat.location = vacc.location
	and deat.date = vacc.date  


	--Total Population vs Population 

select deat.continent, deat.date, deat.population, deat.location, vacc.new_vaccinations
From PortfolioProject.dbo.CovidDeaths deat
Join PortfolioProject.dbo.CovidVaccinations vacc
	On deat.location = vacc.location
	and deat.date = vacc.date  


	--Total Population Vs Vaccinations
select deat.continent, deat.date, deat.population, deat.location, vacc.new_vaccinations, SUM(CONVERT(INT, vacc.new_vaccinations )) OVER (Partition by deat.Location)
From PortfolioProject.dbo.CovidDeaths deat
Join PortfolioProject.dbo.CovidVaccinations vacc
	On deat.location = vacc.location
	and deat.date = vacc.date  
	order by 2, 3
