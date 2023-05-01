create database project;

use project;

select * from olist_customers_dataset;

select count(*) from olist_customers_dataset;

select * from olist_order_items_dataset;

select * from olist_order_payments_dataset;

select * from olist_order_reviews_dataset;

select * from olist_orders_dataset;

select * from olist_products_dataset;

select * from olist_sellers_dataset;


select if(weekday(order_purchase_timestamp)< 5, "Weekday","weekend") as day_cat, sum(payment_value) from olist_orders_dataset
inner join 
olist_order_payments_dataset
using (order_id)
group by day_cat; 

select count(order_id) from olist_order_reviews_dataset
join 
olist_orders_dataset
using (order_id)
join 
olist_order_payments_dataset
using(order_id)
where review_score = 5 and payment_type = 'credit_card';

with t1 as(
select order_purchase_timestamp,order_delivered_customer_date,product_id from olist_orders_dataset
inner join
olist_order_items_dataset
using(order_id)
)
select avg(datediff(order_delivered_customer_date,order_purchase_timestamp)) from t1
inner join
olist_products_dataset
using(product_id)
where product_category_name = 'pet_shop';



/*Q4 Average price and payment values from customers of sao paulo city
*/

with t3 as(
with t2 as (
select order_id, customer_city from olist_customers_dataset
join
olist_orders_dataset
using (customer_id)
)
select order_id ,customer_city, price from t2
join
olist_order_items_dataset
using (order_id)
)
select avg(price), avg(payment_value) from t3
join
olist_order_payments_dataset
using (order_id)
where customer_city = 'Sao paulo' ; 


with t4 as (
select order_purchase_timestamp,order_delivered_customer_date,review_score from olist_order_reviews_dataset
join 
olist_orders_dataset
using (order_id)
)
select review_score, avg(datediff(order_delivered_customer_date,order_purchase_timestamp)) as dif from t4
group by review_score;