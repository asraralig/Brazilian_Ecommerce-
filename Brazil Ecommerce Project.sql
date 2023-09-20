create database Brazilian_Ecommerce;
use Brazilian_Ecommerce;

 select * from olist_customers_dataset;
 select * from order_items_dataset
 select * from geolocation_dataset;
 select * from order_payments_dataset;
 select * from order_reviews_dataset;
 select * from sellers_dataset
 select * from products_dataset
 select * from product_category_name_translation
 select * from orders_dataset
 
 

 SELECT table_name, table_schema
FROM informatiON_schema.tables
WHERE table_type = 'BASE TABLE'
ORDER BY table_name ASC;

--Q1.write queary to analyse sales for each year and each state*/

with deliver_status as(
select * from orders_dataset
where order_status='delivered')
select datepart(year,d.order_purchase_timestamp) as In_year,
o.customer_state,SUM(odr.price) as Total_amount from deliver_status d
join olist_customers_dataset o on d.customer_id=o.customer_id
join order_items_dataset odr on odr.order_id=d.order_id
group by o.customer_state,DATEPART(year,d.order_purchase_timestamp)
order by In_year,Total_amount desc


--Q2-which Payment_type is mostly used across the country
select pd.payment_type,(sum(od.price))as Amount_per_type_card from order_items_dataset od
join order_payments_dataset pd on od.order_id=pd.order_id
group by pd.payment_type
order by Amount_per_type_card desc

--Q3 Which customer gives good reviews

select 
case 
when ord.price<2000 then 'Low_budget_customer'
when ord.price between 2000 and 4000 then 'Medium_budget_customer'
when ord.price > 4000 then 'High_budget_customer'
end as client_budget,
AVG(oor.review_score) as Avg_review
from order_items_dataset ord
join order_reviews_dataset oor
on ord.order_id=oor.order_id
group by case 
when ord.price<2000 then 'Low_budget_customer'
when ord.price between 2000 and 4000 then 'Medium_budget_customer'
when ord.price > 4000 then 'High_budget_customer'
end 
order by Avg_review desc

--Q4- High Rated Seller
select ord.order_status,count(distinct oid.seller_id) as count_of_sellter,sd.seller_state from orders_dataset ord
 join order_items_dataset oid on ord.order_id=oid.order_id
 join sellers_dataset sd on oid.seller_id=sd.seller_id
 where ord.order_status= 'delivered'
 group by ord.order_status,sd.seller_state
 order by count_of_sellter desc

--Q5 Low Rated Seller
 select ord.order_status,count(distinct oid.seller_id) as count_of_sellter,sd.seller_state from orders_dataset ord
 join order_items_dataset oid on ord.order_id=oid.order_id
 join sellers_dataset sd on oid.seller_id=sd.seller_id
 where ord.order_status not like 'delivered'
 group by ord.order_status,sd.seller_state
 order by count_of_sellter desc

 --Q6 Seller who did pre-dlivery

 create or alter view[Seller's Pre-delivery] as
 select ord.order_status,oid.seller_id from orders_dataset ord
 join order_items_dataset oid  on ord.order_id=oid.order_id
 join sellers_dataset sd on oid.seller_id=sd.seller_id
 where ord.order_delivered_customer_date<ord.order_estimated_delivery_date
 group by ord.order_status,oid.seller_id;
 select * from [Seller's Pre-delivery];

 --Q7 Percentage of pre_delivery

create or alter view [Pre_delivery_Percent] as
select SUM(case when order_delivered_customer_date<order_estimated_delivery_date then 1 else 0 end)
as success_order,count(order_id) as total_order
from orders_dataset

select success_order*100/total_order as Percetnage_of_pre_delivery from Pre_delivery_Percent

--Q8 Percentage of Later delivery
create or alter view [Late_delivery_Percent] as
select SUM(case when order_delivered_customer_date>order_estimated_delivery_date then 1 else 0 end)
as success_order,count(order_id) as total_order
from orders_dataset

select success_order*100/total_order as Percetnage_of_late_delivery from Late_delivery_Percent

--Q9 Percentage of Not delivery
create or alter view [Delay_delivery_Percent] as
select SUM(case when order_delivered_customer_date IS null then 1 else 0 end)
as delay_delivered,count(order_id) as total_order
from orders_dataset

select delay_delivered*100/total_order Percetnage_of_late_delivery from Delay_delivery_Percent

-- Q 10- What are the top-selling products and categories?

select pcc.product_category_name_english,(oid.price) as Total_sell from order_items_dataset oid
join products_dataset pd 
on pd.product_id=oid.product_id
join product_category_name_translation pcc on pd.product_category_name=pcc.product_category_name
group by pcc.product_category_name_english,oid.price 
order by Total_sell desc

--Q 11- State which are getting more cancel

 select ol.customer_state,count(ord.order_status) as total_cancel from orders_dataset ord
 join olist_customers_dataset ol on ord.customer_id=ol.customer_id
 where ord.order_status='canceled'
 group by ol.customer_state
 order by total_cancel desc;


 --Q 12-Show the amount for each product id.

 select oid.product_id,pcd.product_category_name_english,sum(oid.price) as total_of_product,count(oid.price) as count_of_product
 from order_items_dataset oid
 join products_dataset pd on oid.product_id=pd.product_id
 join product_category_name_translation pcd on pd.product_category_name=pcd.product_category_name_english
 group by oid.product_id,pcd.product_category_name_english
 order by total_of_product desc

--Q 13- Customer per year per state

 select count(distinct(ocd.customer_id)) as Exist_customer,ocd.customer_state,datepart(year,od.order_purchase_timestamp) as Years
 from olist_customers_dataset ocd
 join orders_dataset od on ocd.customer_id=od.customer_id
 group by ocd.customer_state,datepart(year,od.order_purchase_timestamp)
 order by Years,Exist_customer asc

 --Q 14- How many order placed in each city and each year.
  select * from orders_dataset
 select * from olist_customers_dataset;

 select count(distinct od.order_id) as order_placed,ocd.customer_state,DATEPART(year,order_purchase_timestamp) In_year from orders_dataset od
 join olist_customers_dataset ocd on od.customer_id=ocd.customer_id
 group by ocd.customer_state,DATEPART(year,order_purchase_timestamp)

 -- Q15-show thre trend over year and city

 with sales_delivered as(
 select * from orders_dataset
 where order_status='delivered')
SELECT c.customer_city,Round(SUM(ooid.price),4) AS Total_sales_Price,DATEPART(year,s.order_purchASe_timestamp) AS in_year, 
COUNT(distinct s.order_id) AS Total_order_delivered
FROM sales_delivered s 
join olist_customers_datASet c ON s.customer_id=c.customer_id
join  order_items_datASet ooid ON ooid.order_id=s.order_id
GROUP BY c.customer_city,DATEPART(year,s.order_purchASe_timestamp)







 
 
 







 












