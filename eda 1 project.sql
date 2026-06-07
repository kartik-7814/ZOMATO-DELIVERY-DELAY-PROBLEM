SELECT * FROM parks_and_recreation.start1;
select * from start1;

-- checking null values
SELECT *
FROM start1
WHERE Delivery_person_Ratings IS NULL;

-- checking the duplicate valuess

SELECT *,
COUNT(*) 
FROM start1
GROUP BY ID
HAVING COUNT(*) > 1;


-- maximum,minimum and average time 
select max(time),min(time),avg(time)
from start1;




-- person who delivery item after 30 minutes
select* from start1
where time > 30;



SELECT Road_traffic_density,
AVG(time) AS avg_delay
FROM start1
GROUP BY Road_traffic_density
ORDER BY avg_delay DESC;


SELECT Weatherconditions,
AVG(time) AS avg_delay
FROM start1
GROUP BY Weatherconditions
ORDER BY avg_delay DESC;








-- avg time to make dilevery in avg distance in city wise
WITH distance_cte AS
(
    SELECT 
        city,
        time AS delivery_time,

        (
            6371 * ACOS(
                COS(RADIANS(Restaurant_latitude)) *
                COS(RADIANS(Delivery_location_latitude)) *
                COS(RADIANS(Delivery_location_longitude) - RADIANS(Restaurant_longitude)) +
                SIN(RADIANS(Restaurant_latitude)) *
                SIN(RADIANS(Delivery_location_latitude))
            )
        ) AS distance_km
        

    FROM start1
)

SELECT 
    city,
    
    ROUND(AVG(distance_km),2) AS avg_city_distance_km,
    
    ROUND(AVG(delivery_time),2) AS avg_delivery_time_min

FROM distance_cte

GROUP BY city

ORDER BY avg_city_distance_km DESC;

-- semi urban take highest time to make delivery


with my_cte as (
select Delivery_person_Ratings,
 AVG(time) AS avg_time

from start1
group by Delivery_person_Ratings
)
select * from my_cte
order by Delivery_person_Ratings desc;


-- avg time on differebt vehicle
select Type_of_vehicle,avg(time)as avg_time
from start1
group by Type_of_vehicle;


-- average time in festival
select Festival,avg(time) as avg_time
from start1
group by Festival;

-- fatset vehicle
select Type_of_vehicle,avg(time) as avg_time
from start1
group by Type_of_vehicle
order by avg_time desc;


-- 1. Which traffic condition causes the highest delivery delay?

SELECT Road_traffic_density,
AVG(time) AS avg_delay
FROM start1
GROUP BY Road_traffic_density
ORDER BY avg_delay DESC
limit 1;
-- jam has the highest delay

-- 2. Which weather condition impacts delivery time the most?

SELECT Weatherconditions,
AVG(time) AS avg_delay
FROM start1
GROUP BY Weatherconditions
ORDER BY avg_delay DESC
limit 1;
--  conditio fog have moost delivery time

 -- 3.Which city has the slowest deliveries?
 

WITH distance_cte AS
(
    SELECT 
        city,
        time AS delivery_time,

        (
            6371 * ACOS(
                COS(RADIANS(Restaurant_latitude)) *
                COS(RADIANS(Delivery_location_latitude)) *
                COS(RADIANS(Delivery_location_longitude) - RADIANS(Restaurant_longitude)) +
                SIN(RADIANS(Restaurant_latitude)) *
                SIN(RADIANS(Delivery_location_latitude))
            )
        ) AS distance_km
        

    FROM start1
)

SELECT 
    city,
    
    ROUND(AVG(distance_km),2) AS avg_city_distance_km,
    
    ROUND(AVG(delivery_time),2) AS avg_delivery_time_min

FROM distance_cte

GROUP BY city

ORDER BY avg_city_distance_km DESC
limit 1;

-- city semi-urban has the highest delivery time

-- 4.Which vehicle type delivers orders the fastest?

select Type_of_vehicle,avg(time) as avg_time
from start1
group by Type_of_vehicle
order by avg_time desc
limit 1;

-- 5.Do festivals increase delivery delays?
select Festival,avg(time) as avg_time
from start1
group by Festival;
-- yes festival delay the delivery

-- 6.Do higher-rated delivery partners deliver faster?
  with my_cte as (
select Delivery_person_Ratings,
 AVG(time) AS avg_time

from start1
group by Delivery_person_Ratings
)
select * from my_cte
order by Delivery_person_Ratings desc;
 -- yes rider with high rating deliver fast
 
-- 7 . Which delivery partners perform best?
select Delivery_person_ID,avg(time) as avg_time
from start1
group by Delivery_person_ID
order by avg_time 
limit 1;





