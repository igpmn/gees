
# Production

* Technology choice production function

* Several pairwise stages of production
    
* Input factors
    * Labor
    * Intermediate imports
    * Commodity inputs
    * Capital

* Real flexibilities to flatten the marginal cost schedule
    * Variable utilization of capital
    * Roundabout production

* Sticky prices


---

## Productivity 

Global productivity component

$$
\Delta \log a_t^{gg} = \rho_a \ \Delta \log a_{t-1}^{gg} 
+ (1-\rho_a) \log \kappa_a \\[10pt]
\kappa_a = \frac{a^{gg}\ss}{a^{gg}\ssm}
$$

<br/>

Area/Country relative productivity component

$$
\log ar_t = \rho_{ar} \ \log ar_{t-1} + (1-\rho_ar) \ \log ar\ss
$$

<br/>

Area/Country productivity

$$
a_t = aa^{gg}_t \cdot ar_t
$$

---


## Technology Choice Production Function

Short-run CES technology

$$
y_t = F\left( ak_t \cdot k_t, \ an_t \cdot n_t \right)
$$

<br/>

subject to a long-run technology frontier

$$
G(ak_t, \ an_t) = a_t
$$

<br/>

with adjustment costs

$$
\frac{1}{2}\ \xi \cdot py_t\cdot y_t \Bigl( \log\frac{ak_t}{an_t} -
\log\frac{ak_{t-1}}{an_{t-1}} \Bigr)^2
$$

---

## Leontief-Cobb-Douglas Case

Short-run Leontief

$$
y_t = ak_t \cdot k_t \\[5pt]
y_t = an_t \cdot n_t 
$$

Long-run Cobb-Douglas

$$
ak_t{}^\gamma \cdot an_t{}^{1-\gamma} = a_t
$$

<br/>

Without adjustment costs, this is perfectly equivalent (up to a scale
constant) to

$$
y_t = a_t \cdot k_t{}^\gamma \cdot n_t{}^{1-\gamma}
$$

---

## Production Stages

Combine imports from other areas

$$
m_t = F_4\left( m_t^1, \dots, m_t^A \right)
$$

$$
m_t = mm_t + mch_t + mih_t + mcg_t + mih_t + mxx_t
$$

Combine non-commodity variable factors

$$
y3_t = F_3\Bigl[ mm_t, \ \left(nh_t - \gamma_{n0} \cdot nh\ss\right) \cdot \xnf_t \Bigr]
$$


Combine variable factors with capital

$$
y2_t = F_2\Bigl( ukh_t,\ kg_t,\ y3_t \Bigr) \\[5pt]
ukh_t = u_t \cdot kh_t
$$

Add dependence on commodity inputs

$$
y1_t = F_1\Bigl( y2_t,\ mq_t \Bigr)
$$

Add a roundabout production layer and sticky prices

$$
y_t - z_t = F_0(y1_t,\ z_t) \\[10pt]
y_t = ych_t + yih_t + ycg_t + yig_t + yxx_t
$$

---

## Sticky Prices

Maximize profits

$$
py_t \cdot y_t \ \left(1 + jp_t\right) - py0_t \cdot y0_t
$$

with the price adjustment costs given by
$$
jp_t 
=\frac{1}{2} \ \xi_{py} \ \Bigl( \Delta \log py_t - \Delta \log py_t^\ref \Bigr)^2
$$

Point of reference in price setting

$$
\Delta \log py_t^\ref = \zeta_{py}\Delta \log py_{t-1} + (1-\zeta_{py})
\log \kappa_{py}\\[10pt]
\kappa_{py} = \frac{py\ss}{py\ssm}
$$

---

## Production Sector Total Profits

$$
zy_t 
= py_t \cdot y0_t \ \left( 1 - jy_t \right)
- pm_t \cdot mm_t 
- w_t \cdot nh_t \cdot \xnf_t 
- puk_t \cdot uk_t
- 
$$

---

## Final Goods Assembly

$$
ch = F\Bigl( ych_t,\ mch_t \Bigr)
$$




