{% macro create_primary_key(table_name, primary_key_column) %}
    {% set sql %}
        ALTER TABLE {{ table_name }} 
        ADD CONSTRAINT pk_{{ table_name }} 
        PRIMARY KEY ({{ primary_key_column }});
    {% endset %}
    {{ return(sql) }}
{% endmacro %}
