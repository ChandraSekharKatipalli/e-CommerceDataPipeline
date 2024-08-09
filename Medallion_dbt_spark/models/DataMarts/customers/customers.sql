{{
    config(
        materialized = "table",
        file_format = "delta",
        location_root = "/mnt/gold/Customers"
    )
}}

with users_snapshot as (
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

orders_snapshot as (
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

transformed as (
    select
        u.id AS user_id,
        u.created_at AS user_created_at,
        u.name,
        u.email,
        u.address,
        u.city,
        u.state,
        u.zip,
        u.birth_date,
        o.id AS order_id,
        o.created_at AS order_date,
        o.total AS order_total
FROM 
    users_snapshot u
LEFT JOIN 
    orders_snapshot o ON u.id = o.user_id
)

select * from transformed