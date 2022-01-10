<div style="page-break-after: always;"></div>

# Structure of GEES Modules

There are two model options available:
- (open) autarky economy
- multi-area world

---

## Building Multi-Area World

### Open Autarky

![Open autarky|600](C:\Users\daniela.milucka\Documents\GEES_model\gees-model-codes\codes\docs\figures\open_autarky.jpg)

In order to build a multi-country world with the trade linkages, finance etc., it is good to start with a **one country**, which will serve **as a template** for other areas/countries in the world. This template country will be an open economy (having trade structure), however, it will be self-sufficient, which means that it will satisfy the condition
$$
Country^{1}_{exports} = Country^{1}_{imports}
$$

---

<div style="page-break-after: always;"></div>

### Multiply Autarky

Once this template (open autarky) economy is built, then it can be replicated multiple times (depending how big world we want). The size (economic, demographic), parametrization and general characteristics of these economies will be the same as for the template economy. The economies will be connected via trade linkages, which are symmetric. 

These features of the economies together with symmetric trade condition ensure that the equilibrium for the autarky economy holds also for the multi-area economy/the world. Then individual economies can be altered, for example for different population proportion or productivity growth. 

![Wrappers|600](C:\Users\daniela.milucka\Documents\GEES_model\gees-model-codes\codes\docs\figures\autarky_wrapper.jpg)
