<div style="page-break-after: always;"></div>

# Aggregation and Market Clearing


## Private adjustment costs
$$
\Xi_{h,t} = \Xi_{ih,t} + \Xi_{kh,t} + \Xi_{u,t} + \Xi_{py,t} + \Xi_{x,t}
$$


## Gross domestic product

Nominal GDP (the area's value added at current prices) can be easily
calculated from the expenditure side components:

$$
ngdp_t \equiv pch_t \, ch_t + pih_t \, ih_t
$$

Real GDP, on the other hand, is a more ambiguous concept in an economy
where different components are supplied at different prices. We use a
discrete time Tornqvist index number to construct an approximate measure of
the chain-linked rate of change in real GDP, $\hat{gdp_t}$. 

The Tornqvist index is a weighted average of rates of change in the individual components
$$
\roc{gdp_t} \equiv
w_c \, \roc{ch}_t
$$

where the weights are determined by the nominal expenditure share of the respective component in nominal GDP averaged over the current and previous periods.

