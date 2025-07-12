declare @today_date date;
declare @n int;
set @n = 3;
set @today_date = '2025-06-20';
select dateadd(day, @n*7, @today_date);

select dateadd(day, 8 - datepart(weekday, @today_date), dateadd(day, @n*7, @today_date))
select datepart(weekday, @today_date)
