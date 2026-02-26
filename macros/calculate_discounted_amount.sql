{% macro calculate_discounted_amount(extended_price, discount_percentage, scale=2) %}
    -- Esta macro calcula el precio neto aplicando el descuento y redondeando
    round(
        ( {{ extended_price }} * (1 - {{ discount_percentage }}) ),
        {{ scale }}
    )
{% endmacro %}