<div style="page-break-after: always;"></div>

$$
\newcommand{\tsum}{\textstyle\sum}
\newcommand{\extern}[1]{\mathrm{\mathbf{{#1}}}}
\newcommand{\local}{\mathrm{local}}
\newcommand{\roc}[1]{\hat{#1{}}}
\newcommand{\ss}{\mathrm{ss}}
\newcommand{\E}{\mathbf{E}}
\newcommand{\ref}{{\mathrm{ref}}}
\newcommand{\blog}{\mathbf{log}\ }
\newcommand{\bmax}{\mathbf{max}\ }
\newcommand{\bDelta}{\mathbf{\Delta}}
\newcommand{\bPi}{\mathbf{\Pi}}
\newcommand{\bU}{\mathbf{U}}
\newcommand{\newl}{\\[8pt]}
\newcommand{\betak}{zk}
\newcommand{\betay}{zy}
\notag
$$

# Demography

There are four categories, which describe population/labor supply in the model.

* Total population
* Working age population
* Labor force (labor participation)

Outside the demography module:

* Per-worker labor supply (e.g. per-worker hours worked)

---

## Total Population

Global population trend component, which is driving population in all regions, is defined as
$$
\Delta \log nn^{gg}_t
= \rho_{nn^{gg}} \Delta \log nn^{gg}_{t-1} 
+ (1-\rho_{nn^{gg}}) \Delta \log \kappa_{nn}
$$

$$
\kappa_{nn} = \frac{nn^{gg}_\ss}{nn^{gg}_{\ss-1}}
$$

where $nn_t$ stand for total population and upperscript $gg$ means global (or a feature shared by all regions). 

Total population $nn_t$ is an exogenous process, which is growing over time (possibly with some shocks). In the long run, the global population trend will be growing at a constant rate $\kappa_{nn}$. Total population trend can change up/down, which may have a permanent level effects. However, in the long run, the level of population is not determined, just the population growth rate.



Besides the total population, there are also area/country-specific assumptions. Area/country population is derived from the global population trend and some area/country-specific relative component $nr_t$.

<div style="page-break-after: always;"></div>

Area/Country total population
$$
nn_t = nr_t \cdot nn_t^{gg}
$$

$$
\log(nr_t) 
= \rho_{nr} \log nr_{t-1}
+ (1-\rho_{nr}) \log nr_\ss
$$

If there are no shocks to the relative component $nr_t$, then area/country-specific population follows the global population trend. However, a shock to a relative component $nr_t$ may shift the area/country population even without changes in the underlying global population trend.

---

## Labor Market Population

We assume that particular share of a working population is in its working age.

Working age population
$$
\frac{nw_t}{nn_t} = 
\rho_{nw} \, \frac{nw_{t-1}}{nn_{t-1}}
+ (1-\rho_{nw}) \, \kappa_{nw}
+ \epsilon_{nw,t}
$$

$$
\kappa_{nw} = \frac{nw_\ss}{nn_\ss}
$$

Labor force (participation rate)
$$
\frac{nf_t}{nw_t} = 
\rho_{nf} \, \frac{nf_{t-1}}{nw_{t-1}}
+ (1-\rho_{nf}) \, \kappa_{nf}
+ \epsilon_{nf,t}
$$

$$
\kappa_{nf} = \frac{nf_{ss}}{nw_{ss}}
$$

Long-run changes in these shares will induce changes in consumption path and per capita GDP.
