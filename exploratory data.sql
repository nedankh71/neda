-- exploratory data
select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select * from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

 select company, max(total_laid_off)
 from layoffs_staging2
 group by company
 order by 2 desc;
 
select industry, max(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

 select max(`date`), min(`date`)
 from layoffs_staging2;
 
 select year(`date`), max(total_laid_off)
 from layoffs_staging2
 group by year(`date`)
 order by 2 desc;
 
select stage, max(total_laid_off)
 from layoffs_staging2
 group by stage
 order by 2 desc;
 
select company, sum(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;


SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC;

WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;

 
  
  
 
