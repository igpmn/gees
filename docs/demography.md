# Demography

* Total population

* Working age population

* Labor force (labor participation)

Outside the demography module:

* Per-worker labor supply (e.g. per-worker hours worked)

---

## Total Population

Global Population Trend Component

$$
\Delta \log nn^{gg}_t
= \rho_{nn^{gg}} \Delta \log nn^{gg}_{t-1} 
+ (1-\rho_{nn^{gg}}) \Delta \log \kappa_{nn} \\[10pt]
\kappa_{nn} = \frac{nn^{gg}\ss}{nn^{gg}\ssm}
$$

<br />

Area/Country Total Population

$$
nn_t = nr_t \cdot nn_t^{gg}
$$

$$
\log(nr_t) 
= \rho_{nr} \log nr_{t-1}
+ (1-\rho_{nr}) \log nr\ss
$$


---

## Labor Market Population


Working age population

$$
\frac{nw_t}{nn_t} = 
\rho_{nw} \, \frac{nw_{t-1}}{nn_{t-1}}
+ (1-\rho_{nw}) \, \kappa_{nw}
+ \epsilon_{nw,t} \\[10pt]
\kappa_{nw} = \frac{nw\ss}{nn\ss}
$$

<br/>

Labor force (participation rate)

$$
\frac{\xnf_t}{nw_t} = 
\rho_{\xnf} \, \frac{\xnf_{t-1}}{nw_{t-1}}
+ (1-\rho_{\xnf}) \, \kappa_{\xnf}
+ \epsilon_{\xnf,t} \\[10pt]
\kappa_{\xnf} = \frac{\xnf\ss}{nw\ss}
$$

