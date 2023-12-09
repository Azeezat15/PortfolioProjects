----Cleaning Data In SQL Series 
 Select*
From PortfolioProject.dbo.netflix

--------------------------------------------------------------------------------------------------------------------------------------
--Perform data cleaning to transform data set, Treat the Nulls 
---Check for Null Values Across Multiple Columns
Select * 
From PortfolioProject.dbo.netflix
Where show_id IS NULL
OR type IS NULL
OR title IS NULL
OR director IS NULL
OR title IS NULL
OR country IS NULL
OR date_added IS NULL
OR release_year IS NULL
OR rating IS NULL
OR duration IS NULl
OR listed_in IS NULL

--- Count Number of Rows Where Columns IS NULL using COUNT
Select COUNT (*) 
From PortfolioProject.dbo.netflix
Where show_id IS NULL
OR type IS NULL
OR title IS NULL
OR director IS NULL
OR title IS NULL
OR country IS NULL
OR date_added IS NULL
OR release_year IS NULL
OR rating IS NULL
OR duration IS NULl
OR listed_in IS NULL
-- NO nulls on all columns
----------------------------------------------------------------------------

----CHECK FOR DUPLICATES, NO DUPLICATE

Select show_id, type,COUNT(*) 
From PortfolioProject.dbo.netflix
GROUP BY  show_id, type
	HAVING COUNT(*) >1;
	
Select show_id, type, title, director, country, COUNT(*)
From PortfolioProject.dbo.netflix
GROUP BY show_id, type, title, director, country
having COUNT(*) >1

-----------------------------------------------------------------------

----- Populate Missing Rows 

























Select*
From PortfolioProject.dbo.netflix
order by show_id desc



--Rows with Type as Movie
Select * 
From PortfolioProject.dbo.netflix
Where type = 'Movie'




--Two Types TV show and Movie 
Select DISTINCT(type)
From PortfolioProject.dbo.netflix

Select DISTINCT(country)
From PortfolioProject.dbo.netflix

Select DISTINCT(director), type
From PortfolioProject.dbo.netflix
Where type like 'Movie'

 

Select DISTINCT(director)
From PortfolioProject.dbo.netflix
Where director like 'Aamir%'



--Select * 
--From PortfolioProject.dbo.netflix a
--JOIN PortfolioProject.dbo.netflix b
--	on  a.show_id = b.show_id