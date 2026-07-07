SELECT * FROM {{ ref('dim_listings_cleansed') }}
WHERE minimum_nights < 1
LIMIT 10

-- dbt test -s dim_listings_minimum_nights