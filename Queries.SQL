select v1.date OD1, v1.location CN, v1.daily_vaccinations VOD1, v2.date OD2, v2.daily_vaccinations VOD2, 
    ABS(v1.daily_vaccinations - v2.daily_vaccinations) as "VOD1 - VOD2" 
        from vaccinations v1 join vaccinations v2 on v1.location = v2.location 
            where OD1 = "7/03/2021" 
                and OD2 = "7/03/2022"
                and CN not in 
                (select location from locations
                where iso_code like "OWID");

select location, cumulative from
(SELECT location, sum(daily_vaccinations) as cumulative from vaccinations
GROUP BY location) where cumulative > (select avg(total) from
    (SELECT sum(daily_vaccinations) as total from vaccinations
    GROUP BY location)) and location not in 
                (select location from locations
                where iso_code like "OWID");

                
SELECT l2.location, l2.vaccine from locations_vaccines_used l2
    where l2.location in
    (select l1.location from locations_vaccines_used l1
        GROUP BY l1.location
        ORDER BY count(l1.vaccine) DESC
    LIMIT 10)
;

select s1.source_name as "Source Name", sum(t1.total) as "Total Administered Vaccines", t1.source_url as "Source URL" from (
select total, source_url from
    (SELECT location, sum(daily_vaccinations) as total from vaccinations
    GROUP BY location) t join locations l on t.location = l.location) t1 join
    source s1 on t1.source_url = s1.source_url
    GROUP BY s1.source_name;
    

select t1.date, t1.Australia, t2.China, t3.England, t4."United States" from
((((select date, people_fully_vaccinated as "Australia" from
(select date, people_fully_vaccinated from vaccinations
where location is "Australia" and date like "%2022%")) t1
join           
(select date, people_fully_vaccinated as "China" from
(select date, people_fully_vaccinated from vaccinations
where location is "China" and date like "%2022%")) t2 on t1.date = t2.date)
join
(select date, people_fully_vaccinated as "England" from
(select date, people_fully_vaccinated from vaccinations
where location is "England" and date like "%2022%")) t3 on t1.date = t3.date)
join
(select date, people_fully_vaccinated as "United States" from
(select date, people_fully_vaccinated from vaccinations
where location is "Australia" and date like "%2022%")) t4 on t1.date = t4.date);