# Bluestock Mutual Fund Data Dictionary

---

## 1. dim_fund
**Source:** 01_fund_master.csv

| Column | Data Type | Description |
|--------|-----------|-------------|
| amfi_code | Integer | Unique Mutual Fund Code |
| fund_house | Text | Asset Management Company |
| scheme_name | Text | Mutual Fund Scheme Name |
| category | Text | Fund Category |
| sub_category | Text | Fund Sub-category |
| plan | Text | Growth/Dividend Plan |
| launch_date | Date | Fund Launch Date |
| benchmark | Text | Benchmark Index |
| expense_ratio_pct | Float | Expense Ratio (%) |
| exit_load_pct | Float | Exit Load (%) |
| min_sip_amount | Float | Minimum SIP Amount |
| min_lumpsum_amount | Float | Minimum Lumpsum Amount |
| fund_manager | Text | Fund Manager Name |
| risk_category | Text | Risk Category |
| sebi_category_code | Text | SEBI Category Code |

---

## 2. fact_nav
**Source:** nav_history_cleaned.csv

| Column | Data Type | Description |
|--------|-----------|-------------|
| amfi_code | Integer | Mutual Fund Code |
| date | Date | NAV Date |
| nav | Float | Net Asset Value |

---

## 3. fact_aum
**Source:** 03_aum_by_fund_house.csv

| Column | Data Type | Description |
|--------|-----------|-------------|
| date | Date | Reporting Date |
| fund_house | Text | Asset Management Company |
| aum_lakh_crore | Float | AUM (Lakh Crore) |
| aum_crore | Float | AUM (Crore) |
| num_schemes | Integer | Number of Schemes |

---

## 4. fact_performance
**Source:** scheme_performance_cleaned.csv

| Column | Data Type | Description |
|--------|-----------|-------------|
| amfi_code | Integer | Mutual Fund Code |
| scheme_name | Text | Scheme Name |
| fund_house | Text | Asset Management Company |
| category | Text | Fund Category |
| return_1yr_pct | Float | 1-Year Return (%) |
| return_3yr_pct | Float | 3-Year Return (%) |
| return_5yr_pct | Float | 5-Year Return (%) |
| alpha | Float | Alpha |
| beta | Float | Beta |
| sharpe_ratio | Float | Sharpe Ratio |
| expense_ratio_pct | Float | Expense Ratio (%) |

---

## 5. fact_transactions
**Source:** investor_transactions_cleaned.csv

| Column | Data Type | Description |
|--------|-----------|-------------|
| investor_id | Integer | Investor ID |
| transaction_date | Date | Transaction Date |
| amfi_code | Integer | Mutual Fund Code |
| transaction_type | Text | SIP/Lumpsum/Redemption |
| amount_inr | Float | Transaction Amount |
| state | Text | Investor State |
| city | Text | Investor City |
| payment_mode | Text | Payment Method |
| kyc_status | Text | KYC Verification Status |