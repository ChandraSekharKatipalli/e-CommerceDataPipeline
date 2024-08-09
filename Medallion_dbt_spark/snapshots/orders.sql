{% snapshot orders_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/orders",
        target_schema ='snapshots',
        invalidate_hard_deletes = True,
        unique_key = 'id',
        strategy ='check',
        check_cols ='all'
    )
}}

with orders_snapshot as (
    select
        id,
        created_at,
        user_id,
        product_id,
        discount,
        quantity,
        subtotal,
        tax,
        total
    from {{ source('dbo', 'orders') }}
)

select * from orders_snapshot

{% endsnapshot %}