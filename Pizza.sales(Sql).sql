
-- Que 1:- Retrieve the total number of orders placed.

select count(order_id) as total_order from orders;
show tables;

-- Que 2:- Calculate the total revenue generated from pizza sales.

select
round(sum(order_details.quantity*pizzas.price),2)as total_sales
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

-- Que 3:- Identify the highest-priced pizza.

 select pizza_types.name, pizzas.price
 from pizza_types join pizzas
 on pizza_types.pizza_type_id = pizzas.pizza_type_id
 order by pizzas.price desc limit 1; 
 
 -- Que 4:- Identify the most common pizza size ordered.

 select pizzas.size, count(order_details.order_details_id) as order_count
 from pizzas join order_details
 on pizzas.pizza_id = order_details.pizza_id
 group by pizzas.size order by order_count desc;

-- Que 5:-List the top 5 most ordered pizza types along with their quantities.

select pizza_types.name,
sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;

-- Que 6:- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category,
sum(order_details.quantity)as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- Que 7:- Determine the distribution of orders by hour of the day.

select hour(time),count(order_id) from orders
group by hour(time);

-- Que 8:-Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) from 
(select orders.date,sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.date) as order_quantity;