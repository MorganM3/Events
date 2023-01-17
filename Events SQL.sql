--question: identify the sport/s which was played in all summer events
--Steps:
--1. find total number of summer games
--2. find each sport and how many games they played
--3. compare 1 & 2



with t1 as
   (select count(distinct games) as total_summer_games
    from dbo.athlete_events
    where season = 'Summer'),
t2 as
   (select distinct sport, games
   from dbo.athlete_events
   where season = 'Summer'),
t3 as
  (select sport, count(games) as no_of_games
   from t2
   group by sport)
select *
from t3
join t1 on t1.total_summer_games = t3.no_of_games



--Who are the athletes who won the most gold medals

with t1 as 
   (select name, count (1) as total_medals
    from athlete_events
    where medal = 'Gold'
    group by name
    order by count (1) desc),
t2 as 
	(select *, DENSE_RANK () over(order by total_medals desc) as rnk
	 from t1)
select *
from t2
where rnk <= 5;

--List the total gold, silver, and bronze medals won by each country

select nr.region as country, ae.Medal, count(1) as total_medals
from athlete_events ae
join noc_regions nr
on ae.NOC=nr.NOC
where Medal <> 'na'
group by nr.region, Medal
order by nr.region, Medal;

