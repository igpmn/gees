<div style="page-break-after: always;"></div>

# Notational Conventions

We use the following conventions for naming and denoting variables,
parameters and function:

| Notation                  | Description                | Meaning                                                      |
| ------------------------- | -------------------------- | ------------------------------------------------------------ |
| $x_t$                     | Lowercase latin            | Model variables                                              |
| ${\hat{x}_t}$             | Hat accent                 | Gross rate of change, ${\hat{x}_t} = \left. x_t \middle/ x_{t-1} \right.$ |
| $x_\mathrm{ss}$           | An $\mathrm{ss}$ subscript | Steady state of a model variable                             |
| $x^a_t$                   | Lowercase latin            | Model variables with an explicit area reference              |
| ${\mathrm{\mathbf{x_t}}}$ | Lowercase bold upright     | Model variables externalized in the respective optimization problem |
| ${\textbf{log}}$          | Bold                       | Functions and function components                            |
| $\alpha$                  | Lowercase Greek            | Parameters                                                   |
| $\Pi_t$                   | Uppercase Greek            | Some of model nominal flows                                  |

We denote by $A$ the set of all areas included in the model. Currently,
$A=\{\mathrm{us}, \mathrm{ea}, \mathrm{ch}, \mathrm{rw}\}$. An additional
code, $\mathrm{GG}$, is used to index global common trends, such as the global
productivity trend or the global population trend.

| Area code | Description                           |
| --------- | ------------------------------------- |
| us        | United States (global reference area) |
| ea        | Euro Area                             |
| ch        | China                                 |
| rw        | Rest of world                         |
| gg        | Common global trends                  |

In most of the text, we do not explicitly include  reference area in
the names of variables for the ease of notation. Absent an explicit area
reference, the variable or parameter belongs simply to the respective local
area. 

In several places, we use the concept of a so-called global reference area
(GRA); for instance, the local nominal exchange rates are defined as the
rates between the respective local area's currency and the GRA's currency.
The convention is that the global reference area is always ordered first in
the list of areas. In the baseline setup of the model, the United States is
used as the GRA.

