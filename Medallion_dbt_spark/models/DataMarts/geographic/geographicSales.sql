{{
    config(
        materialized = "table",
        file_format = "delta",
        location_root = "/mnt/gold/geographicSales"
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

users_snapshot as (
    SELECT
        id,
        created_at,
        name,
        email,
        address,
        city,
        state,
        zip,
        birth_date,
        latitude,
        longitude,
        password,
        source
    FROM {{ ref("users_snapshot") }}
),

transformed as (
    select
        o.id AS order_id,
        o.created_at AS order_date,
        o.total AS order_total,
        u.id AS user_id,
        u.city,
        u.state,
        u.zip,
        u.latitude,
        u.longitude,
        p.id AS product_id,
        p.category,
        p.title
FROM 
    orders_snapshot o
JOIN 
    users_snapshot u ON o.user_id = u.id
JOIN 
    products_snapshot p ON o.product_id = p.id
)

select * from transformed