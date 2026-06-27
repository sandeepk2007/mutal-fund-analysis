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