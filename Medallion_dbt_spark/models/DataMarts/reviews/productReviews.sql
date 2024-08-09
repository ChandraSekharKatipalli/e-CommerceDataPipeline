{{
    config(
        materialized = "table",
        file_format = "delta",
        location_root = "/mnt/gold/productReviews"
    )
}}

with reviews_snapshot as (
    SELECT
        id,
        created_at,
        reviewer,
        product_id,
        rating,
        body
    FROM {{ ref("reviews_snapshot") }}
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
        p.id AS product_id,
        p.category,
        p.title,
        p.vendor,
        r.id AS review_id,
        r.created_at AS review_date,
        r.reviewer,
        r.rating AS review_rating,
        r.body AS review_body
FROM 
    products_snapshot p
LEFT JOIN 
    reviews_snapshot r ON p.id = r.product_id
)

select * from transformed