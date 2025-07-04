# Cambios en lab02_dbd con respecto al MR

## Cambios
1. Tablas con nombres en plural.
2. Se agregan el constraint unique para valores que deben ser unicos en tabla, segun regla de negocio.
3. Cambio de tipo valor serial por int generated always as identity.
4. Check para numero_calle > 0.
5. Se agregan default en valor = 0.
6. Se cambia datetime -> timestamp
7. Se cambio en usuarios password por clave
8. Se agrega a pagos la columna total_pagado q seguira siendo calculado pero guardado, no solo calculo
