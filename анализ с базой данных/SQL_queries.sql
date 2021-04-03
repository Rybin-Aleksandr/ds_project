-- первый запрос
select
    model,
    count(flights.departure_time) as flights_amount
FROM
    aircrafts
    INNER JOIN flights on aircrafts.aircraft_code  = flights.aircraft_code
WHERE
    flights.departure_time  :: date between '2018-09-01' and '2018-09-30'
Group by
    model


-- второй запрос
select
    case 
        when model like '%Boeing%' then 'Boeing'
        when model like '%Airbus%' then 'Airbus'
        else 'other'
        end model,
    count(flights.departure_time) as flights_amount 
from
    aircrafts
    inner join flights on aircrafts.aircraft_code = flights.aircraft_code
where 
    extract(month from flights.departure_time) = 9
group by 
   case 
        when model like '%Boeing%' then 'Boeing'
        when model like '%Airbus%' then 'Airbus'
        else 'other'
        end


-- трейтий запрос
select 
    city,
    extract(month from fls.trunc_date) as month_number,
    avg(fls.flights_per_day) as average_flights
from
    (select 
     
                     COUNT(arrival_time) AS flights_per_day,
                     DATE_TRUNC('day', arrival_time) AS trunc_date
                 FROM
                     flights
                 GROUP BY
                     trunc_date) as fls,
    airports
    inner join flights on airports.airport_code = flights.arrival_airport 
where
    cast(flights.arrival_time as date) between '2018-08-01' and '2018-08-31'
                           
group by 
    city


-- четвертый запрос
select
    festival_name,
    extract(week from festival_date) as festival_week
from 
    festivals
where
    festival_date :: date between '2018-07-23' and '2018-09-30' and
    festival_city like '%Моск%'


-- пятый запрос
select
    extract(week from flights.arrival_time) as week_number,
    count(ticket_flights.flight_id) as ticket_amount,
    festival_week,
    festival_name
from 
    flights
    inner join airports on airports.airport_code = flights.arrival_airport
    inner join ticket_flights on ticket_flights.flight_id = flights.flight_id
    left join(
        select
        festival_name,
        extract(week from festival_date) as festival_week
        from
        festivals
        where
        festival_date :: date between '2018-07-23' and '2018-09-30' and
        festival_city like '%Моск%'
    ) as subq
    on festival_week = extract(week from arrival_time)
where
    flights.arrival_time :: date between '2018-07-23' and '2018-09-30' and
    airports.city like '%Моск%'
group by
    week_number,
    festival_week,
    festival_name
order by
    week_number