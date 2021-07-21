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
\notag
$$


# Production

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
+ (1-\rho_a) \log \roc{a}^{gg}_\ss
$$

<br/>

Area-specific relative productivity component

$$
\log ar_t = \rho_{ar} \ \log ar_{t-1} + (1-\rho_ar) \ \log ar_\ss
$$

<br/>

Total area productivity

$$
a_t = a^{gg}_t\, ar_t
$$

---

## Technology Choice Production Function

Short-run CES technology

$$
y_t = F\left( ak_t \, k_t, \ an_t \, n_t \right)
$$

<br/>

subject to a long-run technology frontier

$$
G(ak_t, \ an_t) = a_t
$$

<br/>

with adjustment costs

$$
\frac{1}{2}\ \xi \, py_t\, y_t \Bigl( \log\frac{ak_t}{an_t} -
\log\frac{ak_{t-1}}{an_{t-1}} \Bigr)^2
$$

---

## Leontief-Cobb-Douglas Case

Short-run Leontief

$$
y_t = ak_t \, k_t \\[5pt]
y_t = an_t \, n_t 
$$

Long-run Cobb-Douglas

$$
ak_t{}^\gamma \, an_t{}^{1-\gamma} = a_t
$$

<br/>

Without adjustment costs, this is perfectly equivalent (up to a scale
constant) to

$$
y_t = a_t \, k_t{}^\gamma \, n_t{}^{1-\gamma}
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
y3_t = F_3\Bigl[ mm_t, \ \left(nh_t - \gamma_{n0} \, nh_\ss\right) \, nl_t \Bigr]
$$


Combine variable factors with capital

$$
y2_t = F_2\Bigl( ukh_t,\ kg_t,\ y3_t \Bigr) \\[5pt]
ukh_t = u_t \, kh_t
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
py_t \, y_t \ \left(1 + jp_t\right) - py0_t \, y0_t
$$

with the price adjustment costs given by
$$
jp_t 
=\frac{1}{2} \ \xi_{py} \ \Bigl( \Delta \log py_t - \log \roc{py}_t^\ref \Bigr)^2
$$

Point of reference in price setting

$$
\log \roc{py}_t^\ref = \zeta_{py}\Delta \log py_{t-1} + (1-\zeta_{py})
\log \roc{py}_\ss
$$

---

## Production Sector Total Profits

$$
\Pi_{y,}
= py_t \, y0_t \ \left( 1 - jy_t \right)
- pm_t \, mm_t 
- w_t \, nh_t \, \xnf_t 
- pu_t \, u_t k_t
$$

---

## Final Goods Assembly

$$
ch = F\Bigl( ych_t,\ mch_t \Bigr)
$$



