Select *
From PP_1..CovidDeaths
order by 3, 4

--Select *
--From PP_1..CovidVaccinations
--order by 3, 4

Select location, date, total_cases, new_cases, total_deaths, population
From PP_1..CovidDeaths
order by 1,2

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PP_1..CovidDeaths
order by 1,2

Select location, total_cases, population, (total_cases/population)*100 as PercentageOfPopulationInfected
From PP_1..CovidDeaths
Where location like '%india%'
order by 1,2


--looking at countries with highest infection rate compared to polulation

Select location, population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentageOfPopulationInfected
From PP_1..CovidDeaths
--Where location like '%india%'
Group by location, population
order by PercentageOfPopulationInfected desc

--showing countries with highest death count per population

Select location, Max(cast(total_deaths as int)) as HighestDeathCount
From PP_1..CovidDeaths
Group by location
order by HighestDeathCount desc

--Join covidDeath and Vaccination tables
--Looking at total population vs vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location,
dea.date) as rollingPeopleVaccinated
From PP_1..CovidDeaths dea
Join PP_1..CovidVaccinations vac
On dea.location = vac.location and dea.date = vac.date
Where dea.continent is not null
order by 2,3