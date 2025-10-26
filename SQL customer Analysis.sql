---=======================================customer Analysis=============================================
create view dbo.customer_Report AS 
WITH customer_orders AS (
    SELECT 
        c.customer_key,
        c.customer_number,
        c.country,
        CONCAT(c.first_name ,' ', c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birthdate, GETDATE()) AS customer_age,
        MIN(s.order_date) AS first_order_date,
        MAX(s.order_date) AS last_order_date,
        COUNT(DISTINCT s.order_number) AS total_orders,
        SUM(s.sales_amount) AS total_spending,
        SUM(s.quantity) AS total_quantity,
        COUNT(DISTINCT s.product_key) AS total_products
    FROM [gold.fact_sales] s 
    LEFT JOIN [gold.dim_customers] c ON s.customer_key = c.customer_key 
    GROUP BY 
        c.customer_key,
        c.customer_number,
        c.first_name,
        c.last_name,
        c.birthdate,
        c.country
),
customer_segments AS (
    SELECT 
        customer_key,
        customer_number,
        customer_name,
        country,
        customer_age,
        first_order_date,
        last_order_date,
        total_orders,
        total_spending,
        total_quantity,
        total_products,
        DATEDIFF(month, last_order_date, GETDATE()) AS recency_in_months,
        DATEDIFF(month, first_order_date, GETDATE()) AS Lifespan_in_months,
        CASE 
            WHEN DATEDIFF(month, first_order_date, GETDATE()) = 0 THEN 0 
            ELSE total_spending / DATEDIFF(month, first_order_date, GETDATE())
        END AS avg_monthly_revenue,
        CASE 
            WHEN total_orders = 0 THEN 0
            ELSE total_spending / total_orders
        END AS avg_order_value
    FROM customer_orders
)
SELECT 
    customer_key,
    customer_number,
    customer_name,
    country,
    customer_age,
    first_order_date,
    last_order_date,
    total_orders,
    total_spending,
    total_quantity,
    total_products,
    recency_in_months,
    Lifespan_in_months,
    avg_monthly_revenue,
    avg_order_value,
    CASE 
        WHEN customer_age < 20 THEN 'under_20'
        WHEN customer_age BETWEEN 21 AND 30 THEN '21_30'
        WHEN customer_age BETWEEN 31 AND 40 THEN '31_40'
        WHEN customer_age BETWEEN 41 AND 50 THEN '41_50'
        WHEN customer_age BETWEEN 51 AND 60 THEN '51_60'
        ELSE 'above_60'
    END AS age_group,
    CASE 
        WHEN recency_in_months <= 1 THEN 'Active_customer' 
        WHEN recency_in_months BETWEEN 2 AND 3 THEN 'medium_active_customer'
        ELSE 'low_active_customer'
    END AS customer_activity,
    CASE 
        WHEN total_spending > AVG(total_spending) OVER () THEN 'high_spender'
        WHEN total_spending = AVG(total_spending) OVER () THEN 'Normal_spender'
        ELSE 'below_AVG'
    END AS spending_segment
FROM customer_segments ; 

select * 
from dbo.customer_Report