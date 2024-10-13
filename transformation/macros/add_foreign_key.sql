{% macro add_foreign_key(table_name, constraint_name, foreign_key_columns, ref_table, ref_columns) %}
    {% set sql %}
    DO $$
    BEGIN
        IF NOT EXISTS (
            SELECT 1
            FROM pg_constraint
            WHERE conname = '{{ constraint_name }}'
            AND conrelid = '{{ table_name }}'::regclass
        ) THEN
            ALTER TABLE {{ table_name }}
            ADD CONSTRAINT {{ constraint_name }} FOREIGN KEY ({{ foreign_key_columns | join(', ') }})
            REFERENCES {{ ref_table }} ({{ ref_columns | join(', ') }});
        END IF;
    END $$;
    {% endset %}

    {{ return(sql) }}
{% endmacro %}
