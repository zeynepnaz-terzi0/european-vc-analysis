# What Drives Startup Funding in Europe?
### Testing the Capital Supply Hypothesis with Firm-Level Data

**Author:** Zeynep Naz Terzi | **Date:** May 2026

---

## Overview

European startup funding is highly unequal across countries, and the dominant policy view blames insufficient capital supply. This project challenges that narrative empirically. Using firm-level Crunchbase data on **5,964 European startups across 15 countries**, it argues that the real drivers are structural factors *upstream* of venture capital — angel investor ecosystems, founder recycling culture, and tax policy design.

The central finding: Swedish startups raise on average **3.7× more than Italian startups**, a gap that persists after controlling for sector and funding structure. This cannot be explained by capital supply alone.

---

## Research Question

> Is country of incorporation significantly associated with total venture funding, even after controlling for sector and funding structure?

Specifically: do Swedish startups raise systematically more than Southern European peers, reflecting structural ecosystem advantages rather than capital availability?

---

## Data

- **Source:** [Crunchbase Startup Investments Dataset](https://www.kaggle.com/datasets/arindam235/startup-investments-crunchbase) (Kaggle, 2015)
- **Full dataset:** 54,294 companies, 39 variables
- **Filtered sample:** 5,964 European companies with non-missing, non-zero total funding
- **Countries:** GBR, DEU, FRA, SWE, NLD, ESP, ITA, FIN, BEL, DNK, IRL, CHE, NOR, PRT, POL
- **Unit of analysis:** One company (cross-sectional)

| Variable | Type | Description |
|---|---|---|
| `funding_total_usd` | Continuous | Total funding raised — dependent variable |
| `funding_rounds` | Discrete | Number of funding rounds — primary predictor |
| `venture` | Continuous | VC-specific funding component (USD) |
| `seed` | Continuous | Seed funding component (USD) |
| `angel` | Continuous | Angel funding component (USD) |
| `market` | Nominal | Sector / industry category |
| `country_code` | Nominal | Country of incorporation |
| `status` | Nominal | Operating / Acquired / Closed |

---

## Methods

- **Univariate analysis:** Summary statistics; log-transformation of `funding_total_usd` to address right-skew (power-law distribution)
- **Bivariate analysis:** Pearson correlation matrix; OLS regression (two models); country-level mean comparisons
- **Chi-squared test:** Association between sector and company exit status

---

## Key Findings

### Funding Rounds Are the Dominant Predictor
Each additional funding round is associated with **~92% higher total funding** (β = 0.655, p < 0.001, R² = 0.105). This is consistent with signalling theory: completed rounds reduce investor uncertainty and attract further capital.

### Early-Stage Capital Composition Adds Little
Seed funding is weakly significant; angel funding is not statistically significant (p = 0.439). Adding both to the model raises R² by only 0.002 — confirming that early-stage capital *amounts* do not predict eventual scale.

### Sweden's Structural Premium
Despite contributing only 269 companies (5% of the sample), Swedish startups rank 3rd in mean log-funding (14.5), above Germany (14.4), the UK (14.2), Spain (13.6), and Italy (13.2). This gap persists after controlling for sector and round count.

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
A chi-squared test confirms a significant association between sector and company status (χ² = 44.40, df = 15, p < 0.001). Clean Technology has the highest closure rate (9.6%), reflecting capital intensity and regulatory risk; E-Commerce the lowest (4.0%).

---

## Repository Structure

```
├── analsis.R          # R analysis script
├── figures/
│   ├── hist_log_funding.png   # Distribution of log total funding
│   ├── hist_rounds.png        # Distribution of funding rounds
│   ├── bar_country.png        # Startups by country
│   ├── bar_sector.png         # Startups by sector
│   └── bar_status.png         # Company status breakdown
└── European VC.Rproj
```

---

## Policy Implications

The European Commission's 2025 Startup and Scaleup Strategy focuses on improving access to finance — but this analysis suggests that addresses the symptom rather than the cause. The binding constraint is the **pipeline of investable opportunities**, not capital supply. Effective policy should target the pre-VC ecosystem:

- Angel investor tax reform (modelled on Sweden's 2003 corporate capital gains deferral)
- Pension fund regulations that channel long-term capital toward early-stage investment

---

## Limitations

- Crunchbase data compiled circa 2015 — post-2015 developments not captured
- Cross-sectional design does not permit causal inference

---

## References

- Crunchbase (2015). *Startup Investments Dataset.* Kaggle.
- European Commission (2025). *EU Startup and Scaleup Strategy.*
- Garicano, L. & Strömberg, P. (2026). *Why Sweden Has So Many Unicorns.* Silicon Continent.
- Gompers, P. & Lerner, J. (2000). Money chasing deals? *Journal of Financial Economics, 55*(2), 281–325.
- Invest Europe (2024). *Investing in Europe: Private Equity Activity 2023.*
- Keogh, D. & Johnson, D.K. (2021). Survival of the funded. *Journal of Entrepreneurship, Management and Innovation, 17*(4).
- Nofsinger, J. & Wang, W. (2011). Determinants of start-up firm external financing worldwide. *Journal of Banking & Finance, 35*(9), 2282–2294.
