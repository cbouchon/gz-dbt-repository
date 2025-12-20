with 

source as (

    select * from {{ source('raw', 'ship') }}

),

renamed as (

    select

    from source

)

select * from renamed