--SELECT * 
--FROM portfolioproject1..CovidDeaths 
--where continent is not null
--order by 3,4

--SELECT * 
--FROM portfolioproject1..CovidVaccinations 
--order by 3,4

--SELECT location,date,total_cases,new_cases,total_deaths,population 
--where continent is not null
--from CovidDeaths 
--order by 1,2

--SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathRate
--from CovidDeaths 
--where location='India' and continent is not null
--order by 1,2

--SELECT location,date,population,total_cases,(total_cases/population)*100 as InfectionRate
--from CovidDeaths 
--where location='India' and continent is not null
--order by 1,2

--SELECT location,population,max(total_cases) as MaxTotalCases,max((total_cases/population)*100) as MaxInfectionRate
--from CovidDeaths 
--where continent is not null
--group by location,population
--order by 4 desc

--SELECT location,max(cast(total_deaths as int)) as MaxDeathCount
--from CovidDeaths 
--where continent is not null
--group by location
--order by 2 desc

--SELECT distinct(location) 
--from CovidDeaths 
--where continent is not null
--order by location

--SELECT distinct(location) 
--from CovidDeaths 
--where continent is null
--order by location

--SELECT date,sum(new_cases) as TotalCases,sum(cast(new_deaths as int)) as TotalDeaths,
--sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
--from CovidDeaths
--where continent is not null
--group by date
--order by 1

--SELECT sum(new_cases) as TotalCases,sum(cast(new_deaths as int)) as TotalDeaths,
--sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
--from CovidDeaths
--where continent is not null

--SELECT *
--FROM CovidDeaths dea
--JOIN CovidVaccinations vac
--	on dea.location=vac.location
--	and dea.date=vac.date

--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--FROM CovidDeaths dea
--JOIN CovidVaccinations vac
--	on dea.location=vac.location
--	and dea.date=vac.date
--where dea.continent is not null
--order by 2,3

--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
--sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as CumulativeVaccinated
--FROM CovidDeaths dea
--JOIN CovidVaccinations vac
--	on dea.location=vac.location
--	and dea.date=vac.date
--where dea.continent is not null
--order by 2,3

--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
--sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as CumulativeVaccinated
--FROM CovidDeaths dea
--JOIN CovidVaccinations vac
--	on dea.location=vac.location
--	and dea.date=vac.date
--where dea.continent is not null and dea.location='India'
--order by 2,3

--CTE
--WITH popvsvac(continent,location,date,population,new_vaccinations,CumulativeVaccinated)
--as
--(
--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
--sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as CumulativeVaccinated
--FROM CovidDeaths dea
--JOIN CovidVaccinations vac
--	on dea.location=vac.location
--	and dea.date=vac.date
--where dea.continent is not null
--)
--SELECT *,(CumulativeVaccinated/population)*100 as VaccinationPerc
--from popvsvac

--Temp table
--Drop table if exists #VaccinatedPercentage
--Create table #VaccinatedPercentage
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--CumulativeVaccinated numeric
--)
--Insert into #VaccinatedPercentage
--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
--sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as CumulativeVaccinated
--FROM CovidDeaths dea
--JOIN CovidVaccinations vac
--	on dea.location=vac.location
--	and dea.date=vac.date
--where dea.continent is not null

--SELECT *,(CumulativeVaccinated/population)*100 as VaccinationPerc
--from #VaccinatedPercentage

--Creating a view
--Create view CumulativeVaccinatedPopulation as
--SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,
--sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location,dea.date) as CumulativeVaccinated
--FROM CovidDeaths dea
--JOIN CovidVaccinations vac
--	on dea.location=vac.location
--	and dea.date=vac.date
--where dea.continent is not null
