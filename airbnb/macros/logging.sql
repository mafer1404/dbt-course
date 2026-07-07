{% macro learn_logging() %}
    {% do log("This is a log message from the learn_logging macro.", info=True) %}
{% endmacro %}

-- dbt run-operation learn_logging

-- jinja comment: {# log("This is a log message from the learn_logging macro.", info=True) #}