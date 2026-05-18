# What Drives Startup Funding in Europe?

**Zeynep Naz Terzi** | Bocconi University | Statistics PC Home Assignment | May 2026

---

This project examines the reasons some European startups raise a lot more money than others. The short answer from the data: it depends heavily on which country you're in and how many funding rounds you've completed — but the *why* behind that is harder to pin down.

I used Crunchbase data on 5,964 European startups across 15 countries and ran a mix of summary stats, correlations, regressions, and a chi-squared test. The Sweden vs. Italy gap is the most striking finding. Swedish startups raise on average 3.7× more than Italian ones, and that gap survives even after controlling for sector and round count.

---

## The data

Crunchbase startup investments dataset from Kaggle (compiled around 2015). I filtered to 15 European countries and dropped any company with missing or zero total funding, leaving 5,964 companies. Each row is one company, not a time series.

The UK makes up 38% of the sample, which is worth keeping in mind when interpreting country-level results. Sweden is only 5% of companies. However, punches well above its weight in average funding.

| Variable | Description |
|---|---|
| `funding_total_usd` | Total funding raised — this is what I'm trying to explain |
| `funding_rounds` | Number of rounds completed |
| `venture` / `seed` / `angel` | Breakdown of funding by type |
| `market` | Sector |
| `country_code` | Country of incorporation |
| `status` | Operating / Acquired / Closed |

---

## What I did

**Univariate:** Summary stats for all numeric variables. `funding_total_usd` is very right-skewed (mean is 6× the median), so I log-transformed it throughout.

**Bivariate:** Pearson correlations, covariance matrix, and three OLS regressions. Additionally, a chi-squared test for sector vs. exit status, and a Welch t-test comparing Sweden and Italy directly.

---

## Results

### Funding rounds

The strongest predictor at the firm level. Each additional round is *associated with* about 92% higher total funding (β = 0.655, p < 0.001). This association is not particularly causal, companies that do well raise more rounds *and* more money, so the direction of influence goes both ways.

### The three regression models

| | Model 1 | Model 2 | Model 3 |
|---|---|---|---|
| `funding_rounds` | 0.655*** | 0.644*** | 0.621*** |
| `seed` | — | sig.** | — |
| `angel` | — | n.s. | — |
| `country_SWE` | — | — | **0.873***** |
| Sector controls | — | — | Yes |
| R² | 0.105 | 0.107 | 0.237 |

*Reference country in Model 3: Italy. \*\*\* p < 0.001, \*\* p < 0.01*

Model 2 adds seed and angel funding — but these are actually components of the dependent variable, so that's a bit circular. Model 3 is cleaner: it adds country and sector dummies instead, with Italy as the baseline.

Model 3 is the most interesting one. Sweden's coefficient is 0.873 (p < 0.001), meaning Swedish startups are associated with about 139% more funding than Italian ones after controlling for rounds and sector (e^0.873 − 1 ≈ 1.39). R² jumps from 0.107 to 0.237, which shows country matters a lot.

### Country averages

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

### Sector and exit status

Chi-squared test between sector group and status: χ² = 44.40, df = 15, p < 0.001. Therefore, the sector is associated with whether a company is still operating, acquired, or closed. Clean Technology has the highest closure rate (9.6%), E-Commerce the lowest (4.0%). I checked the expected cell counts — a few are on the small side, so these sector-level numbers should be read carefully.

---

## Limitations

- **The Sweden result is associative.** Model 3 shows Swedish startups raise more. It doesn't show the reason. The angel ecosystem/tax reform/founder recycling explanation comes from external literature, not from this data.

- **Funding rounds is endogenous.** Better companies raise more rounds and more money simultaneously. Treating rounds as a clean predictor of funding overstates its explanatory role.

- **Model 2 has a component regressor problem.** `seed` and `angel` are part of `funding_total_usd`. Including parts of the outcome as predictors is conceptually complicated. Model 3 sidesteps this.


---

## Files

```
├── analysis.R       # full analysis script
├── figures/         # all plots
└── European VC.Rproj
```

---

## References

- Crunchbase (2015). Startup Investments Dataset. Kaggle.
- European Commission (2025). EU Startup and Scaleup Strategy.
- Garicano, L. & Strömberg, P. (2026). Why Sweden Has So Many Unicorns. Silicon Continent.
- Gompers, P. & Lerner, J. (2000). Journal of Financial Economics, 55(2), 281–325.
- Invest Europe (2024). Investing in Europe: Private Equity Activity 2023.
- Keogh, D. & Johnson, D.K. (2021). Journal of Entrepreneurship, Management and Innovation, 17(4).
- Nofsinger, J. & Wang, W. (2011). Journal of Banking & Finance, 35(9), 2282–2294.
