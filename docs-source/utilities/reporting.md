
# Reporting utilities

## `report.basicWithSteady`

### Syntax

    report.basicWithSteady(model, simulationDb, steadyDb, range, title, legends, fileName)

### Input argument

__`model`__ [ Model ]
> 
> Model object from which the simulation was generated; the model object is
> only needed to retrieve the list of areas.
>

__`simulationDb`__ [ struct ]
> 
> Databank with simulation results to be reported; each time series in the databank can
> contain either one column, or two columns (comparison of two alternative
> simulations).
>

__`steadyDb`__ [ struct ]
> 
> Databank with steady state paths for all variables; the databank will be
> used to draw indicative steady lines in the charts.
> 

__`range`__ [ Dater ]
> 
> Date range on which the charts and tables will be reported.
> 

__`title`__ [ string ]
> 
> Report title.
> 

__`legends`__ [ string ]
> 
> An array of strings that will be used to label the individual columns of
> time series plotted in the charts. 
> 

__`fileName`__ [ string ]
> 
> File name (including its path if necessary) under which the report will
> be saved. No extension will be added to the file name; it should
> therefore be entered with `.html`.
> 


