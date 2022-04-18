---
title: Demography
---

# :fontawesome-solid-children:  Demography

--8<-- "docs-source/model/math.md"


## Overview

The demography module determines the following population quantities; all
of them are considered to be simple exogenous processes not affected by the
rest of the model:

* Global population trend

* Area's total population

* Area's working age population

* Area's labor force (labor participation)


Endogenously within the model, we then model
per-worker labor supply (e.g. per-worker hours).



=== ":fontawesome-solid-square-root-variable:  Math equations"

    --8<-- "docs-source/model/demography-math.md"


=== ":fontawesome-solid-file-code:  Model source code"

    --8<-- "model-source/demography.md"

