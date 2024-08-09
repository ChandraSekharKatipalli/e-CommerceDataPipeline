{% snapshot reviews_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/reviews",
        target_schema ='snapshots',
        invalidate_hard_deletes = True,
        unique_key = 'id',
        strategy ='check',
        check_cols ='all'
    )
}}

with reviews_snapshot as (
    select
        id,
        created_at,
        reviewer,
        product_id,
        rating,
        body
    from {{ source('dbo', 'reviews') }}
)

select * from reviews_snapshot

{% endsnapshot %}