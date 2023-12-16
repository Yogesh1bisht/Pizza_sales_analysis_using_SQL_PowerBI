select * from pizzas;

-- doing some transformation / tweks of dataset-- 
rename table pizza_sales_excel_file to pizzas;

alter table pizza_sales_excel_file
modify order_date date;

alter table pizza_sales_excel_file
modify order_time time;

-- KPI-- 
-- Total revenue
select round(sum(total_price ),2) as total_revenue
from pizzas;

-- Average order value
select round(sum(total_price)/count(distinct order_id),2) as avg_order
from pizzas;

-- Total pizzas sold
select sum(quantity) as total_pizza_sold
from pizzas;

-- total orders
select count(order_id)
from pizzas;

-- average pizza per order
select round(sum(quantity)/count(distinct order_id) ,2) as per_order
from pizzas;

-- daily trends for total orders
select dayname(order_date) as day , count(distinct order_id) 
from pizzas
group by day;

-- hourly  trends for total orders
select hour(order_time) as hourly_trend , count(distinct order_id)
from pizzas
group by hourly_trend;

-- percentage of sales by pizza category
select pizza_category,sum(total_price), round(sum(total_price) * 100/
(select sum(total_price) from pizzas where month(order_date) = 2),2) as total_per
from pizzas
where month(order_date) = 2
group by pizza_category;

-- percentage of sales by pizza size
select pizza_size,sum(total_price), round(sum(total_price) * 100/
(select sum(total_price) from pizzas where month(order_date) = 2),2) as total_per
from pizzas
where month(order_date) = 2
group by pizza_size;

-- total pizza sold by pizza category
select pizza_category, count(quantity)
from pizzas
group by pizza_category;

-- top 5 bset selling pizza 
select pizza_name , sum(quantity) as total
from pizzas
group by pizza_name
order by total desc
limit 5;

-- top 5 worst selling pizza 
select pizza_name , sum(quantity) as total
from pizzas
group by pizza_name
order by total 
limit 5;

