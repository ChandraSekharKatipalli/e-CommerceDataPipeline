{{
    config(
        materialized = "table",
        file_format = "delta",
        location_root = "/mnt/gold/sales"
    )
}}

with orders_snapshot as (
    SELECT
        id,
        created_at,
        user_id,
        product_id,
        discount,
        quantity,
        subtotal,
        tax,
        total
    FROM {{ ref("orders_snapshot") }}
),

products_snapshot as (
    SELECT
        id,
        created_at,
        category,
        ean,
        price,
        quantity,
        rating,
        title,
        vendor
    FROM {{ ref("products_snapshot") }}
),

transformed as (
    select
        o.id AS order_id,
        o.created_at AS order_date,
        o.user_id,
        o.product_id,
        o.discount,
        o.quantity,
        o.subtotal,
        o.tax,
        o.total,
        p.category,
        p.price,
        p.title,
        p.vendor
FROM 
    orders_snapshot o
JOIN 
    products_snapshot p ON o.product_id = p.id
)

select * from transformed