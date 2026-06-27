<<<<<<< HEAD
-- Dimension Table: Fund
CREATE TABLE dim_fund (
    amfi_code INTEGER PRIMARY KEY,
    fund_house TEXT,
    scheme_name TEXT,
    category TEXT,
    sub_category TEXT,
    plan TEXT,
    launch_date DATE,
=======
PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS dim_fund (
    fund_id INTEGER PRIMARY KEY,
    amfi_code INTEGER NOT NULL UNIQUE,
    fund_house TEXT NOT NULL,
    scheme_name TEXT NOT NULL,
    category TEXT,
    sub_category TEXT,
    plan TEXT,
    launch_date TEXT,
>>>>>>> 0f13ad022ab8788254ba295c3d4c955f72ba82e5
    benchmark TEXT,
    expense_ratio_pct REAL,
    exit_load_pct REAL,
    min_sip_amount REAL,
    min_lumpsum_amount REAL,
    fund_manager TEXT,
    risk_category TEXT,
<<<<<<< HEAD
    sebi_category_code TEXT
);

-- Dimension Table: Date
-- ======================
CREATE TABLE dim_date (
    date DATE PRIMARY KEY
);


-- Fact Table: NAV
-- =====================
CREATE TABLE fact_nav (
    amfi_code INTEGER,
    date DATE,
    nav REAL,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code),
    FOREIGN KEY (date) REFERENCES dim_date(date)
);

-- Fact Table: Transactions
-- ========================
CREATE TABLE fact_transactions (
    investor_id INTEGER,
    transaction_date DATE,
    amfi_code INTEGER,
    transaction_type TEXT,
    amount_inr REAL,
=======
    sebi_category_code TEXT,
    CHECK (launch_date IS NULL OR launch_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
);

CREATE TABLE IF NOT EXISTS dim_date (
    date_id INTEGER PRIMARY KEY,
    full_date TEXT NOT NULL UNIQUE,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL CHECK (quarter BETWEEN 1 AND 4),
    month INTEGER NOT NULL CHECK (month BETWEEN 1 AND 12),
    month_name TEXT,
    day INTEGER NOT NULL CHECK (day BETWEEN 1 AND 31),
    day_of_week INTEGER CHECK (day_of_week BETWEEN 0 AND 6),
    is_month_end INTEGER NOT NULL DEFAULT 0 CHECK (is_month_end IN (0, 1)),
    is_quarter_end INTEGER NOT NULL DEFAULT 0 CHECK (is_quarter_end IN (0, 1)),
    CHECK (full_date GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
);

CREATE TABLE IF NOT EXISTS fact_nav (
    fund_id INTEGER NOT NULL,
    date_id INTEGER NOT NULL,
    nav REAL NOT NULL CHECK (nav >= 0),
    PRIMARY KEY (fund_id, date_id),
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS fact_transactions (
    transaction_id INTEGER PRIMARY KEY,
    investor_id TEXT NOT NULL,
    fund_id INTEGER NOT NULL,
    date_id INTEGER NOT NULL,
    transaction_type TEXT NOT NULL,
    amount_inr REAL NOT NULL CHECK (amount_inr >= 0),
>>>>>>> 0f13ad022ab8788254ba295c3d4c955f72ba82e5
    state TEXT,
    city TEXT,
    city_tier TEXT,
    age_group TEXT,
    gender TEXT,
    annual_income_lakh REAL,
    payment_mode TEXT,
    kyc_status TEXT,
<<<<<<< HEAD
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- Fact Table: Performance
-- =================
CREATE TABLE fact_performance (
    amfi_code INTEGER,
    scheme_name TEXT,
    fund_house TEXT,
    category TEXT,
    plan TEXT,
=======
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS fact_performance (
    fund_id INTEGER NOT NULL,
    date_id INTEGER NOT NULL,
>>>>>>> 0f13ad022ab8788254ba295c3d4c955f72ba82e5
    return_1yr_pct REAL,
    return_3yr_pct REAL,
    return_5yr_pct REAL,
    benchmark_3yr_pct REAL,
    alpha REAL,
    beta REAL,
    sharpe_ratio REAL,
    sortino_ratio REAL,
    std_dev_ann_pct REAL,
    max_drawdown_pct REAL,
<<<<<<< HEAD
    aum_crore REAL,
    expense_ratio_pct REAL,
    morningstar_rating INTEGER,
    risk_grade TEXT,
    FOREIGN KEY (amfi_code) REFERENCES dim_fund(amfi_code)
);

-- Fact Table: AUM
-- ===================
CREATE TABLE fact_aum (
    date DATE,
    fund_house TEXT,
    aum_lakh_crore REAL,
    aum_crore REAL,
    num_schemes INTEGER,
    FOREIGN KEY (date) REFERENCES dim_date(date)
);
=======
    morningstar_rating INTEGER CHECK (
        morningstar_rating IS NULL OR morningstar_rating BETWEEN 1 AND 5
    ),
    risk_grade TEXT,
    return_1yr_pct_anomaly INTEGER NOT NULL DEFAULT 0 CHECK (return_1yr_pct_anomaly IN (0, 1)),
    return_3yr_pct_anomaly INTEGER NOT NULL DEFAULT 0 CHECK (return_3yr_pct_anomaly IN (0, 1)),
    return_5yr_pct_anomaly INTEGER NOT NULL DEFAULT 0 CHECK (return_5yr_pct_anomaly IN (0, 1)),
    PRIMARY KEY (fund_id, date_id),
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS fact_aum (
    fund_id INTEGER NOT NULL,
    date_id INTEGER NOT NULL,
    aum_crore REAL NOT NULL CHECK (aum_crore >= 0),
    PRIMARY KEY (fund_id, date_id),
    FOREIGN KEY (fund_id) REFERENCES dim_fund(fund_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX IF NOT EXISTS idx_dim_fund_fund_house
    ON dim_fund (fund_house);

CREATE INDEX IF NOT EXISTS idx_fact_nav_date
    ON fact_nav (date_id);

CREATE INDEX IF NOT EXISTS idx_fact_transactions_fund_date
    ON fact_transactions (fund_id, date_id);

CREATE INDEX IF NOT EXISTS idx_fact_transactions_investor
    ON fact_transactions (investor_id);

CREATE INDEX IF NOT EXISTS idx_fact_performance_date
    ON fact_performance (date_id);

CREATE INDEX IF NOT EXISTS idx_fact_aum_date
    ON fact_aum (date_id);
>>>>>>> 0f13ad022ab8788254ba295c3d4c955f72ba82e5
