{% snapshot users_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/users",
        target_schema ='snapshots',
        invalidate_hard_deletes = True,
        unique_key = 'id',
        strategy ='check',
        check_cols ='all'
    )
}}

with users_snapshot as (
    select
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
    from {{ source('dbo', 'users') }}
)

select * from users_snapshot

{% endsnapshot %}