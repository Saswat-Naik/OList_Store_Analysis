use project;
alter table olist_orders_dataset add column day_type varchar(100);

set sql_safe_updates = 0;

update olist_orders_dataset
set day_type= if (dayofweek(order_purchase_timestamp) in (1,7),"weekend","weekday");

select 
day_type,
round(sum(payment_value),2) as "Total payment"
from olist_orders_dataset D2 inner join
olist_order_payments_dataset D1
on D2.order_id = D1.order_id
group by day_type;
select count(*)
from olist_orders_dataset;

select count(*)
from olist_orders_dataset;

select 
review_score as "Review Score",
count(D1.order_id) as number_of_orders,
payment_type as "Payment Type"
from olist_order_reviews_dataset D1
INNER JOIN olist_order_payments_dataset D2
ON D1.order_id=D2.order_id
where review_score=5
and payment_type ="Credit_Card";


select
 product_category_name as "Product Name",
round (avg(datediff(order_delivered_customer_date,order_approved_at))) as "Average days"
from olist_orders_dataset od
inner join olist_order_items_dataset oid
on od.order_id=oid.order_id
inner join olist_products_dataset opd
on oid.product_id=opd.product_id
where product_category_name="pet_shop";

select customer_city,concat('$',format(avg(price),2)) as "Average Price",concat('$',format(avg(payment_value),2)) as "Average Payment Value" from
olist_order_payments_dataset 
inner join olist_order_items_dataset oid
on olist_order_payments_dataset.order_id=oid.order_id
inner join olist_orders_dataset od
on olist_order_payments_dataset.order_id=od.order_id
inner join olist_customers_dataset cd
on od.customer_id=cd.customer_id
where customer_city="sao paulo";


select order_purchase_timestamp as "order purchase",order_delivered_customer_date as "order deliver",review_score 
from olist_orders_dataset od
inner join olist_order_reviews_dataset ord 
on od.order_id=ord.order_id;

#using datediff()
select datediff(order_purchase_timestamp,order_delivered_customer_date) as "shipping_days",avg(review_score) 
from olist_orders_dataset od
join olist_order_reviews_dataset ord 
on od.order_id=ord.order_id 
group by shipping_days ;

