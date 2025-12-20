WITH 

sales AS (
    SELECT 
        date_date, 
        orders_id, 
        products_id, 
        revenue, 
        quantity
    FROM {{ ref('stg_raw__sales')}}
    ),

products AS (
    SELECT
        products_id,
        purchase_price
    FROM {{ ref('stg_raw__product')}} 
    ),
sales_margin AS (
    SELECT 
        s.date_date, 
        s.orders_id, 
        s.products_id, 
        s.revenue, 
        s.quantity,
        p.purchase_price,

        --metrics--
        ROUND(p.purchase_price * s.quantity) AS purchase_cost,
        ROUND(s.revenue - (p.purchase_price * s.quantity)) AS margin

    FROM sales s
    LEFT JOIN products p
    USING (products_id)
)
SELECT *
FROM sales_margin
