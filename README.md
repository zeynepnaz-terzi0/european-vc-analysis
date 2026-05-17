# What Drives Startup Funding in Europe?
### Testing the Capital Supply Hypothesis with Firm-Level Data

**Author:** Zeynep Naz Terzi | **Date:** May 2026 | **Course:** Statistics PC Home Assignment, Bocconi University

---

## Overview

European startup funding is highly unequal across countries. The dominant policy view attributes this to insufficient capital supply. This project examines whether firm-level characteristics — primarily funding rounds, sector, and country of incorporation — are associated with total venture funding, using Crunchbase data on **5,964 European startups across 15 countries**.

The analysis does not directly measure capital supply (no VC fund counts, dry powder, investor density, or GDP controls are included). What it tests is whether country of incorporation is significantly associated with funding outcomes after controlling for sector and funding structure. The Sweden–Italy gap (3.7× difference in average funding) motivates the country-level comparison, but the result is associative — the data cannot establish whether the mechanism is angel ecosystems, tax policy, founder recycling culture, or unmeasured confounders.

---

## Research Question

> Is country of incorporation significantly associated with total venture funding, after controlling for sector and funding structure?

---

## Data

- **Source:** [Crunchbase Startup Investments Dataset](https://www.kaggle.com/datasets/arindam235/startup-investments-crunchbase) (Kaggle, ~2015)
- **Full dataset:** 54,294 companies, 39 variables
- **Filtered sample:** 5,964 European companies with non-missing, non-zero total funding
- **Countries:** GBR, DEU, FRA, SWE, NLD, ESP, ITA, FIN, BEL, DNK, IRL, CHE, NOR, PRT, POL
- **Unit of analysis:** One company (cross-sectional)

| Variable | Type | Description |
|---|---|---|
| `funding_total_usd` | Continuous | Total funding raised — dependent variable |
| `funding_rounds` | Discrete | Number of funding rounds |
| `venture` | Continuous | VC-specific funding component (USD) |
| `seed` | Continuous | Seed funding component (USD) |
| `angel` | Continuous | Angel funding component (USD) |
| `market` | Nominal | Sector / industry category |
| `country_code` | Nominal | Country of incorporation |
| `status` | Nominal | Operating / Acquired / Closed |

---

## Methods

- **Univariate analysis:** Summary statistics (mean, median, SD, IQR); log-transformation of `funding_total_usd` to address right-skew
- **Bivariate analysis:** Pearson correlation matrix; covariance matrix; three OLS regression models; country-level mean comparisons
- **Chi-squared test:** Association between broad sector group and company status; expected cell counts verified
- **Welch t-test:** Direct comparison of log-funding between Swedish and Italian startups

---

## Key Findings

### Funding Rounds Are Associated With Higher Funding
Each additional funding round is *associated with* approximately **92% higher total funding** (β = 0.655, p < 0.001, R² = 0.105). Note that `funding_rounds` is likely endogenous — more successful companies both raise more money and complete more rounds — so this coefficient should not be read as causal.

### Early-Stage Capital Composition Adds Little
In Model 2, `seed` and `angel` are added alongside `funding_rounds`. Note that both are components of `funding_total_usd` (the dependent variable), which makes their inclusion conceptually problematic. Despite this, the finding is consistent: angel is not statistically significant (p = 0.439) and R² increases by only 0.002. Model 3 avoids this issue by dropping both.

### Country Is Significantly Associated With Funding
Three regression models were estimated, all with `log_funding` as the dependent variable:

| | Model 1 | Model 2 | Model 3 |
|---|---|---|---|
| Intercept | 13.142*** | 13.130*** | 13.028*** |
| `funding_rounds` | 0.655*** | 0.644*** | 0.621*** |
| `seed` | — | sig.** | — |
| `angel` | — | n.s. | — |
| `country_SWE` | — | — | **0.873***** |
| Broad sector controls | — | — | Yes |
| R² | 0.105 | 0.107 | **0.237** |

*Reference category in Model 3: Italy. *** p < 0.001, ** p < 0.01*

Swedish startups are associated with approximately **139% more funding** than Italian startups after controlling for funding rounds and broad sector (e^0.873 − 1 = 1.39). A Welch t-test on the Sweden–Italy subsample confirms the difference is statistically significant. The reason for this gap — whether tax design, angel ecosystems, or other structural factors — cannot be determined from this data.

### Country Rankings

| Country | Mean log-funding | N |
|---|---|---|
| Switzerland | 14.8 | 184 |
| France | 14.5 | 766 |
| **Sweden** | **14.5** | **269** |
| Germany | 14.4 | 627 |
| UK | 14.2 | 2,284 |
| Spain | 13.6 | 462 |
| Italy | 13.2 | 244 |
| Poland | 12.5 | 76 |

### Sector and Exit Outcomes
A chi-squared test finds a significant association between sector group and company status (χ² = 44.40, df = 15, p < 0.001). Expected cell counts were checked; some sector/status combinations are small and should be interpreted cautiously. The sector grouping is coarse — five named sectors plus "Other" — and hides within-group variation (e.g. fintech, health tech, enterprise software). Clean Technology shows the highest closure rate (9.6%); E-Commerce the lowest (4.0%).

---

## Repository Structure

```
├── analysis.R         # R analysis script
├── figures/
│   ├── hist_log_funding.png   # Distribution of log total funding
│   ├── hist_rounds.png        # Distribution of funding rounds
│   ├── bar_country.png        # Startups by country
│   ├── bar_sector.png         # Startups by sector
│   └── bar_status.png         # Company status breakdown
└── European VC.Rproj
```

---

## Limitations

- **No capital-supply variable.** The models contain no measure of VC fund supply, dry powder, investor density, domestic VC availability, GDP, or pension-fund allocation. The title's "capital supply hypothesis" is motivated theoretically but not directly tested with supply-side data.
- **Associative, not causal.** Country fixed effects in Model 3 show that Swedish startups raise more than Italian ones on average, but cannot identify whether the mechanism is tax policy, angel networks, founder recycling, or unobserved selection into the dataset.
- **Endogenous regressor.** `funding_rounds` is part of the funding process, not an independent cause of it. Coefficients should be interpreted as associations, not effects.
- **Component regressor issue in Model 2.** `seed` and `angel` are sub-components of the dependent variable `funding_total_usd`. Model 3 is preferred as it avoids this.
- **Coarse sector control.** `market_grouped` collapses all non-top-5 sectors into "Other," masking heterogeneity within that category. This is a broad adjustment, not a full sector control.
- **Chi-squared cell counts.** Some sector × status combinations have small expected counts; results should be interpreted with caution.
- **Stale data.** The Crunchbase dataset reflects the ecosystem circa 2015. Policy references to 2025–2026 strategies cannot be validated against this data.

---

## References

- Crunchbase (2015). *Startup Investments Dataset.* Kaggle.
- European Commission (2025). *EU Startup and Scaleup Strategy.*
- Garicano, L. & Strömberg, P. (2026). *Why Sweden Has So Many Unicorns.* Silicon Continent.
- Gompers, P. & Lerner, J. (2000). Money chasing deals? *Journal of Financial Economics, 55*(2), 281–325.
- Invest Europe (2024). *Investing in Europe: Private Equity Activity 2023.*
- Keogh, D. & Johnson, D.K. (2021). Survival of the funded. *Journal of Entrepreneurship, Management and Innovation, 17*(4).
- Nofsinger, J. & Wang, W. (2011). Determinants of start-up firm external financing worldwide. *Journal of Banking & Finance, 35*(9), 2282–2294.
