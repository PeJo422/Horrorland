{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='ticket_id'
) }}

with
feedbacks as (
    select
        f.ticket_id,
        f.rating,
        f.feedback_date,
        f.would_recommend,
        f.felt_scared,
        f.worth_the_price,
        f.updated_at
    from {{ ref('stg_people__customer_feedbacks') }} as f
    {% if is_incremental() %}
        where f.updated_at > (
            select max(fb.feedback_updated_at)
            from {{ this }} as fb
        )
    {% endif %}
),

tickets as (
    select
        t.ticket_id,
        t.customer_id,
        t.haunted_house_id,
        t.visit_date,
        t.visit_hour,
        t.ticket_type,
        t.ticket_price,
        t.group_size,
        t.updated_at
    from {{ ref('stg_attractions__haunted_house_tickets') }} as t
    {% if is_incremental() %}
        where
            t.updated_at > (
                select max(tc.ticket_updated_at)
                from {{ this }} as tc
            )
            or t.ticket_id in (
                select f.ticket_id from feedbacks as f
            )
    {% endif %}
)

select
    t.ticket_id,
    t.customer_id,
    t.haunted_house_id,
    t.ticket_type,
    t.ticket_price,
    t.visit_date,
    f.rating,
    f.would_recommend,
    f.felt_scared,
    f.worth_the_price,
    t.updated_at as ticket_updated_at,
    f.updated_at as feedback_updated_at,
    case
        when extract(month from t.visit_date) = 10
            then extract(day from t.visit_date) - 31
    end as days_to_halloween,
    case
        when t.visit_hour between 9 and 12 then 'Morning'
        when t.visit_hour between 13 and 17 then 'Afternoon'
        when t.visit_hour between 18 and 21 then 'Evening'
        else 'Night'
    end as visit_time_of_day,
    case
        when t.group_size > 4 then 'Large Group'
        when t.group_size > 2 then 'Medium Group'
        else 'Small Group'
    end as group_category,
    round(t.ticket_price / t.group_size, 2) as price_per_person
from tickets as t
left join feedbacks as f
    on t.ticket_id = f.ticket_id
