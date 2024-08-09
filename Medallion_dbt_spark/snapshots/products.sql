{% snapshot products_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/products",
        target_schema ='snapshots',
        invalidate_hard_deletes = True,
        unique_key = 'id',
        strategy ='check',
        check_cols ='all'
    )
}}

with products_snapshot as (
    select
        id,
        created_at,
        category,
        ean,
        price,
        quantity,
        rating,
        title,
        vendor
    from {{ source('dbo', 'products') }}
)

select * from products_snapshot

{% endsnapshot %}