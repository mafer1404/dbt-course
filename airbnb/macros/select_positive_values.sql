{% macro select_positive_values(model, column_name) %}

    SELECT *
    FROM {{ model }}
    WHERE {{ column_name }} > 0

{% endmacro %}

-- dbt compile --inline '{{ select_positive_values("dim_listings_cleansed", "minimum_nights") }}'

-- dbt show --inline '{{ select_positive_values("dim_listings_cleansed", "minimum_nights") }}'