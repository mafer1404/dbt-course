{% macro no_empty_strings(model) %}
    {%- for col in adapter.get_columns_in_relation(model) -%}
        {%- if col.is_string() %}
            {{ col.name }} IS NOT NULL AND {{ col.name }} <> '' AND
        {%- endif %}
    {%- endfor %}
    TRUE
{% endmacro %}

-- dbt compile --inline 'SELECT * FROM {{ ref("dim_listings_cleansed")}} WHERE {{ no_empty_strings(ref("dim_listings_cleansed")) }}'

-- dbt show --inline 'SELECT * FROM {{ ref("dim_listings_cleansed")}} WHERE {{ no_empty_strings(ref("dim_listings_cleansed")) }}'
