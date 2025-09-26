with
source as (
    select
        customer_id,
        age,
        email,
        registration_date,
        preferred_scare_level,
        dbt_valid_from,
        dbt_valid_to,
        case
            when gender in ('M', 'Male') then 'Male'
            when gender in ('F', 'Female') then 'Female'
            else 'Other'
        end as gender,
        to_boolean(lower(is_vip_member)) as is_vip_member
    from {{ ref('scd_customers') }}
)

select *
from source
