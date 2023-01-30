
# GPMN Global Economy Equilibrium Scenario Builder


The Global Economy Equilibrium Scenario Builder (GEESr) is a practical
macroeconomic scenario analysis framework built around a multi-area DSGE
model. The framework is currently implemented in
[Matlab&trade;](https://www.mathworks.com) with the use of the
[Iris Toolbox](https://www.iris-toolbox.com).

GEESr is being developed and maitained by a [Global Projection Model Network](https://www.igpmn.org)
team of contributors.

## Model documentation

[Documentation website for GEES](https://igpmn.github.io/GEES)


## Workshop setup script for GEES workshop participants

* Install [Git](git-scm.com) locally on your computer

* In Matlab, run the following query in the command window

```
>> userpath()
```

This gives you the path to the default working directory (a "user
directory") Matlab assumes

* Download the [setup script](https://github.com/igpmn/gees/blob/master/setupForWorkshop.m),
and save it locally on your computer to the default user folder from the step before

* Start Matlab, switch to the default user directory, and run the setup
  script

```
>> cd(userpath())
>> setupForWorkshop
```

* Switch to the GEES folder and start up the Iris Toolbox

```
>> cd igpmn-gees
>> addpath ../iris-bleeding/; iris.startup
```

