# Infrastructure of GEES Model

## Structure of Model Folders 

| Project folder       | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `source/`            | Model source files (text files written in IrisT model language) |
| `docs/`              | Documentation folder                                         |
| `+model/`            | Subpackage folder to contain different variants/setups of the model |
| `+model/xxx`         | Subpackage to create and store variant xxx of the model      |
| `+simulate`          | Subpackage folder to contain simulation exercises            |
| `+simulate/xxx`      | Subpackage to contain simulation and reporting files for exercise xxx |
| `+compareSteady`     | Subpackage folder to contain comparative static exercises    |
| `+compareSteady/xxx` | Subpackage to contain comparative static and reporting files for exercise xxx |
| `+scenario`          | Subpackage folder to contain scenarios                       |
| `+scenario/+xxx`     | Subpackage folder to contain scenario and reporting files for exercise xxx |
| `+utils`             | Subpackage with utility functions                            |

---
<div style="page-break-after: always;"></div>

## Explanation of Essential GEES Model Folders

\+ sign before the folder name
- It provides a flexible way of structuring folders and subfolders

`+model/`

- includes (so far) three particular versions of the model
  - +autarky – one model for the whole world/closed economy
  - +global4A – baseline version (global 4 area: US, EZ, CN, Rest of the world)
  - +symmetric2A – 2 country model version (everything is perfectly symmetric)
- *In order to create a new model version, create a new +subfolder*

`+simulate`

- Includes set of simulation experiments
- To provide intuition about the main transmission mechanisms and convergence properties
  - +areaDisinflation
  - +areaGovDebt
  - +areaMonetaryShock
  - +areaPopulationIncrease
  - +areaProductivityImpovements
  - +areaTariffs
  - +areaWAP
  - +disinflation
  - +globalPopulation
  - +globalProductivity
  - +interestFloor
    - Each of these folders has function “run.m”, which runs the experiment
- Simulation experiments are written in a way that they can run at any version of the model (e.g. you can run autarky model with productivity increase or global 4 area model with global productivity increase).
- Produces HTML report with the results

`+compareSteady`

- Stores another set of experiments – comparative steady state
- Calculates and reports how the long-run of the model changes in response to changes in some parameters or other assumptions
  - +areaGovDebt
  - +areaMonetaryNeutrality
  - +areaPriceLevel
  - +areaProductivity
  - +areaRiskAppetiteCapital
  - +areaWAP
  - +globalGovDebt
  - +globalPopulation
  - +globalProductivity
  - +globalRiskAppetiteCapital
    - Each of these folders has function “run.m”, which runs the experiment
- Produces table with results and comparative Excel sheet to see the change between the two steady states and evaluation of differences

`+scenario`

- Real event-related simulations linked to recent developments

`source/`

- Stores all model source files
- Due to flexibility the model is split into small models describing different part of the economy
  - commodity.model
  - demography.model
  - finance.model
  - fiscal.model
  - globals.model
  - local.model –local households, producers
  - open.model – exporters, balance of payments
  - trade.model – international trade linkages
  - *wrapper-autarky.model* – special file that creates a necessary closure for autarky models (a single losed economy)
  - *wrapper-multiarea.model* - special file that creates a necessary closure for multiarea model version

`docs/`

- documentation of the model is split into sections
- documentation is written in a Markup text language
  - you can use for example *Obsidian* – software package, which transforms and shows Markdown files directly in a document-readable format.

