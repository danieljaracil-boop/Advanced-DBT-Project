{% test test_no_negative_values(model, column_name) %}

select
    {{ column_name }} as amount
from {{ model }}
where {{ column_name }} < 0

{% endtest %}