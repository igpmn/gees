---
title: Commodity supply
---

# :fontawesome-solid-gas-pump:  Commodity supply

Each area owns a certain percentage of the total global commodity volume
produced (supplied). The global commodity supply side is modeled as one
single sector, and its output is then divided among the individual areas
using the commodity distribution parameters $\lambda_t^{aa}$. Each area's
demand for (use of) commodity can be lower or higher than its own share of
global commodity supply; in that case, the area becomes a net commodity
exporter or importer.

![Global commodity market](commodity.png)

<br />

=== ":fontawesome-solid-square-root-variable:  Algebra"

    --8<-- "model/commodity-math.md"


=== ":fontawesome-solid-file-code:  Model source code"

    --8<-- "model-source/commodity.md"

