<<<<<<< HEAD
-- 1. Top 5 Fund Houses by AUM
-- ==================================
SELECT fund_house, aum_crore
FROM fact_aum
ORDER BY aum_crore DESC
LIMIT 5;

-- 2. Average NAV Per Month
-- =================================
SELECT
    strftime('%Y-%m', date) AS month,
    AVG(nav) AS average_nav
FROM fact_nav
GROUP BY strftime('%Y-%m', date)
ORDER BY month;

-- 3. SIP Year-wise Growth
-- ===================================
SELECT
    strftime('%Y', transaction_date) AS year,
    SUM(amount_inr) AS total_sip_amount
FROM fact_transactions
WHERE transaction_type='SIP'
GROUP BY year
ORDER BY year;

-- 4. Transactions by State
-- ==============================
SELECT
    state,
    COUNT(*) AS total_transactions
FROM fact_transactions
GROUP BY state
ORDER BY total_transactions DESC;

-- 5. Funds with Expense Ratio Less Than 1%
-- ======================================================
SELECT
    scheme_name,
    expense_ratio_pct
FROM fact_performance
WHERE expense_ratio_pct < 1
ORDER BY expense_ratio_pct;

-- 6. Average Expense Ratio by Category
-- ======================================
SELECT
    category,
    AVG(expense_ratio_pct) AS avg_expense_ratio
FROM fact_performance
GROUP BY category;

-- 7. Top 10 Funds by 5-Year Return
-- =====================================
SELECT
    scheme_name,
    return_5yr_pct
FROM fact_performance
ORDER BY return_5yr_pct DESC
LIMIT 10;

-- 8. Number of Schemes by Fund House
-- ======================================
SELECT
    fund_house,
    COUNT(*) AS total_schemes
FROM dim_fund
GROUP BY fund_house
ORDER BY total_schemes DESC;

-- 9. Average Transaction Amount by Payment Mode
-- ======================================================
SELECT
    payment_mode,
    AVG(amount_inr) AS average_amount
FROM fact_transactions
GROUP BY payment_mode;

-- 10. Count of Funds by Risk Category
-- ====================================
SELECT
    risk_category,
    COUNT(*) AS total_funds
FROM dim_fund
GROUP BY risk_category
ORDER BY total_funds DESC;
=======
-- 1. Largest schemes by reported AUM.
SELECT
    scheme_name,
    fund_house,
    category,
    plan,
    aum_crore,
    expense_ratio_pct
FROM fact_performance
ORDER BY aum_crore DESC
LIMIT 5;

-- 2. Monthly average NAV across all available schemes.
SELECT
    strftime('%Y-%m', date) AS nav_month,
    ROUND(AVG(nav), 4) AS avg_nav,
    COUNT(*) AS nav_observations
FROM fact_nav
GROUP BY nav_month
ORDER BY nav_month;

-- 3. SIP inflow growth compared with the same month in the previous year.
SELECT
    month,
    sip_inflow_crore,
    LAG(sip_inflow_crore, 12) OVER (ORDER BY month) AS sip_inflow_prev_year,
    ROUND(
        100.0 * (sip_inflow_crore - LAG(sip_inflow_crore, 12) OVER (ORDER BY month))
        / NULLIF(LAG(sip_inflow_crore, 12) OVER (ORDER BY month), 0),
        2
    ) AS calculated_yoy_growth_pct,
    yoy_growth_pct AS reported_yoy_growth_pct
FROM monthly_sip_inflows
ORDER BY month;

-- 4. Investor transaction value and volume by state.
SELECT
    state,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount_inr), 2) AS total_amount_inr,
    ROUND(AVG(amount_inr), 2) AS avg_transaction_amount_inr
FROM fact_transactions
GROUP BY state
ORDER BY total_amount_inr DESC;

-- 5. Low-cost funds with expense ratios under 1%.
SELECT
    amfi_code,
    scheme_name,
    fund_house,
    category,
    plan,
    expense_ratio_pct,
    aum_crore,
    return_3yr_pct
FROM fact_performance
WHERE expense_ratio_pct < 1
ORDER BY expense_ratio_pct, aum_crore DESC;

-- 6. Funds with the strongest 3-year returns.
SELECT
    category,
    scheme_name,
    fund_house,
    plan,
    return_3yr_pct,
    benchmark_3yr_pct,
    ROUND(return_3yr_pct - benchmark_3yr_pct, 2) AS excess_return_3yr_pct
FROM fact_performance
WHERE return_3yr_pct IS NOT NULL
ORDER BY return_3yr_pct DESC
LIMIT 10;

-- 7. Monthly transaction trend split by transaction type.
SELECT
    strftime('%Y-%m', transaction_date) AS transaction_month,
    transaction_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount_inr), 2) AS total_amount_inr
FROM fact_transactions
GROUP BY transaction_month, transaction_type
ORDER BY transaction_month, transaction_type;

-- 8. Total and average monthly net inflows by category.
SELECT
    category,
    ROUND(SUM(net_inflow_crore), 2) AS total_net_inflow_crore,
    ROUND(AVG(net_inflow_crore), 2) AS avg_monthly_net_inflow_crore,
    COUNT(DISTINCT month) AS months_reported
FROM category_inflows
GROUP BY category
ORDER BY total_net_inflow_crore DESC;

-- 9. Sector exposure based on portfolio market value.
SELECT
    sector,
    ROUND(SUM(market_value_cr), 2) AS total_market_value_cr,
    ROUND(AVG(weight_pct), 2) AS avg_holding_weight_pct,
    COUNT(DISTINCT stock_symbol) AS unique_stocks,
    COUNT(DISTINCT amfi_code) AS funds_holding_sector
FROM portfolio_holdings
GROUP BY sector
ORDER BY total_market_value_cr DESC;

-- 10. Funds ahead of benchmark with drawdown better than -25%.
SELECT
    scheme_name,
    fund_house,
    category,
    plan,
    return_3yr_pct,
    benchmark_3yr_pct,
    ROUND(return_3yr_pct - benchmark_3yr_pct, 2) AS excess_return_3yr_pct,
    max_drawdown_pct,
    sharpe_ratio
FROM fact_performance
WHERE return_3yr_pct > benchmark_3yr_pct
  AND max_drawdown_pct > -25
ORDER BY excess_return_3yr_pct DESC, sharpe_ratio DESC
LIMIT 10;
>>>>>>> 0f13ad022ab8788254ba295c3d4c955f72ba82e5
