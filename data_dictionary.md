# Data Dictionary

The processed folder contains the cleaned datasets used in the SQLite database.
Dates are stored in ISO format where a full date is available (`YYYY-MM-DD`) and
monthly series use `YYYY-MM`. Monetary values are kept in Indian rupees, crore,
lakh, or lakh crore as stated in each column name.

## Processed Files

| File | Rows | SQLite table | What it contains |
|---|---:|---|---|
| `01_fund_master.csv` | 40 | `dim_fund` | Basic fund details such as AMFI code, fund house, category, plan, benchmark, fees, and minimum investment values. |
| `03_aum_by_fund_house.csv` | 90 | `fact_aum` | Fund-house level AUM snapshots with scheme counts. |
| `04_monthly_sip_inflows.csv` | 48 | `monthly_sip_inflows` | Monthly SIP inflows, active SIP accounts, new SIP accounts, SIP AUM, and YoY growth. |
| `05_category_inflows.csv` | 144 | `category_inflows` | Monthly net inflows grouped by mutual fund category. |
| `06_industry_folio_count.csv` | 21 | `industry_folio_count` | Monthly folio counts for the industry and major fund segments. |
| `09_portfolio_holdings.csv` | 322 | `portfolio_holdings` | Fund portfolio holdings by stock, sector, weight, value, price, and portfolio date. |
| `10_benchmark_indices.csv` | 8,050 | `benchmark_indices` | Daily closing values for benchmark indices. |
| `investor_transactions_cleaned.csv` | 32,778 | `fact_transactions` | Investor-level transaction records with date, amount, location, demographics, payment mode, and KYC status. |
| `nav_history_cleaned.csv` | 46,000 | `fact_nav` | Daily NAV history by AMFI code. |
| `scheme_performance_cleaned.csv` | 40 | `fact_performance` | Fund-level return, risk, benchmark, AUM, expense ratio, rating, and anomaly fields. |

## Common Keys

| Column | Meaning |
|---|---|
| `amfi_code` | Fund identifier used to connect fund master, NAV, performance, portfolio, and transactions data. |
| `fund_house` | Asset management company or mutual fund house name. |
| `scheme_name` | Name of the mutual fund scheme. |
| `date` | Daily reporting date, used in NAV, AUM, and benchmark data. |
| `month` | Monthly reporting period for SIP, inflow, and folio datasets. |
| `category` | Mutual fund category, such as Large Cap, Mid Cap, Debt, Hybrid, or similar grouping. |

## Column Notes

### Fund Master

| Column | Description |
|---|---|
| `amfi_code` | Unique AMFI scheme code. |
| `fund_house` | Mutual fund house managing the scheme. |
| `scheme_name` | Full scheme name. |
| `category` | Broad asset class or fund grouping. |
| `sub_category` | More specific fund classification. |
| `plan` | Plan type, such as Regular or Direct. |
| `launch_date` | Scheme launch date. |
| `benchmark` | Index used to compare fund performance. |
| `expense_ratio_pct` | Annual expense ratio as a percentage. |
| `exit_load_pct` | Exit load percentage, if applicable. |
| `min_sip_amount` | Minimum SIP amount in INR. |
| `min_lumpsum_amount` | Minimum one-time investment amount in INR. |
| `fund_manager` | Named fund manager. |
| `risk_category` | Risk level assigned to the scheme. |
| `sebi_category_code` | SEBI category reference code. |

### AUM by Fund House

| Column | Description |
|---|---|
| `date` | AUM reporting date. |
| `fund_house` | Fund house name. |
| `aum_lakh_crore` | Assets under management in lakh crore. |
| `aum_crore` | Assets under management in crore. |
| `num_schemes` | Number of schemes reported for the fund house. |

### SIP Inflows

| Column | Description |
|---|---|
| `month` | SIP reporting month. |
| `sip_inflow_crore` | Monthly SIP inflow in crore. |
| `active_sip_accounts_crore` | Active SIP accounts in crore. |
| `new_sip_accounts_lakh` | New SIP accounts opened during the month, in lakh. |
| `sip_aum_lakh_crore` | SIP-linked AUM in lakh crore. |
| `yoy_growth_pct` | Reported year-over-year SIP growth percentage. |

### Category Inflows and Folios

| Column | Description |
|---|---|
| `net_inflow_crore` | Net money flow for a category during the month, in crore. |
| `total_folios_crore` | Total industry folios in crore. |
| `equity_folios_crore` | Equity folios in crore. |
| `debt_folios_crore` | Debt folios in crore. |
| `hybrid_folios_crore` | Hybrid fund folios in crore. |
| `others_folios_crore` | Folios outside equity, debt, and hybrid groupings. |

### Portfolio Holdings

| Column | Description |
|---|---|
| `stock_symbol` | Exchange ticker or stock symbol. |
| `stock_name` | Company name. |
| `sector` | Sector classification for the holding. |
| `weight_pct` | Portfolio weight of the holding. |
| `market_value_cr` | Holding value in crore. |
| `current_price_inr` | Stock price in INR. |
| `portfolio_date` | Date of the reported portfolio snapshot. |

### NAV, Performance, and Transactions

| Column | Description |
|---|---|
| `nav` | Net asset value for a scheme on a given date. |
| `return_1yr_pct`, `return_3yr_pct`, `return_5yr_pct` | Fund returns over the stated time periods. |
| `benchmark_3yr_pct` | Three-year benchmark return. |
| `alpha`, `beta`, `sharpe_ratio`, `sortino_ratio` | Risk and performance measures. |
| `std_dev_ann_pct` | Annualized standard deviation percentage. |
| `max_drawdown_pct` | Largest drawdown percentage in the period. |
| `morningstar_rating` | Rating value from 1 to 5 where available. |
| `risk_grade` | Text risk grade for the scheme. |
| `return_1yr_pct_anomaly`, `return_3yr_pct_anomaly`, `return_5yr_pct_anomaly` | Flags marking unusual return values found during cleaning. |
| `investor_id` | Investor identifier in the transaction dataset. |
| `transaction_date` | Date of investor transaction. |
| `transaction_type` | Type of transaction, such as SIP, purchase, or redemption. |
| `amount_inr` | Transaction amount in INR. |
| `state`, `city`, `city_tier` | Investor location fields. |
| `age_group`, `gender`, `annual_income_lakh` | Investor demographic fields. |
| `payment_mode` | Payment channel used for the transaction. |
| `kyc_status` | KYC verification status. |
