with
valid_domains as (
    select domain from {{ ref('valid_domains') }}
),

customer_data as (
    select
        customer_id,
        age,
        email,
        gender,
        is_vip_member,
        preferred_scare_level,
        registration_date
    from {{ ref('stg_people__customers') }}
    where dbt_valid_to is null
)

select
    cd.customer_id,
    cd.age,
    cd.email,
    cd.gender,
    cd.preferred_scare_level,
    cd.registration_date,
    coalesce(
        regexp_like(
            cd.email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
        )
        and length(cd.email) - length(regexp_replace(cd.email, '@', '')) = 1
        and exists (
            select 1
            from valid_domains as vd
            where cd.email like '%' || vd.domain
        ),
        false
    ) as is_valid_email,
    case
        when cd.age < 18 then 'Under 18'
        when cd.age between 18 and 24 then '18-24'
        when cd.age between 25 and 34 then '25-34'
        when cd.age between 35 and 49 then '35-49'
        else '50+'
    end as age_group,
    case
        when cd.is_vip_member then 'VIP Member'
        else 'Regular Visitor'
    end as customer_category
from customer_data as cd
