# Tuesday model experiments

## Creating model object
* Composing a model object of model source files
* Preparser and preparsed model files
* Wrapper source files

## Steady state of a BGP model
* Autarky model
* Symmetric 2-area model
* Level and growth components of steady state
* Choosing a point on BGP

## Neutral comparative static (along growth drivers)
* Moving along the global population BGP line
* Moving along the global productivity BGP line
* Choosing a nominal level
## Lunchwork
* Create `model-source/households_xy.md` by copying the original model source file
* Declare a new variable `rrh` (real interest rate facing households derived from the nominal interest rate `rh` and inflation `roc_pc`) and define an equation for it
* Both the interest rate and inflation rates are defined as **gross rates of change** (meaning 1.05 means 5%)
* Copy `model.autarky.create` into `model.autarky.create_xy` and make sure it reads the model file `model-source/households_xy.md`
* Run the creation function to get a model object with the new real rate, and run a comparative static experiment increasing productivity level by 10%.
* Investigate the impact on real interest rate.
## Parameterized comparative static
* Relative population
* Labor force assumptions
* Relative productivity, tradables/nontradables sectors
* Changing financial positions in multiarea versions

## Introductory dynamic simulations
* Spill-over of area-specific inflationary shocks
* Basic types of assumptions about information set evolution