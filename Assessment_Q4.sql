-- Q4: Customer Lifetime Value (CLV) Estimation

-- Formula:
CLV = (total_transactions / tenure_months) * 12 * avg_profit
avg_profit = 0.001 * confirmed_amount

-- SQL Logic:
-- Assessment_Q4.sql

-- Step 1: Summarize total transactions and total confirmed deposit amount per customer
WITH txn_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,                      -- Total number of transactions made
        SUM(confirmed_amount) AS total_value                 -- Total confirmed deposit value (in kobo)
    FROM savings_savingsaccount
    GROUP BY owner_id
),

-- Step 2: Calculate tenure (in months) since user signup
user_tenure AS (
    SELECT 
        id AS customer_id,
        name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months -- Months since signup
    FROM users_customuser
),

-- Step 3: Calculate estimated CLV based on simplified model
clv_calc AS (
    SELECT 
        u.customer_id,
        u.name,
        u.tenure_months,
        t.total_transactions,
        -- Apply the CLV formula:
        -- (total_transactions / tenure) * 12 * avg_profit_per_transaction
        ROUND(((t.total_transactions / u.tenure_months) * 12 * 
              (0.001 * t.total_value / t.total_transactions)) , 2) AS estimated_clv
              -- 0.001 represents 0.1% profit per transaction
    FROM user_tenure u
    JOIN txn_summary t ON u.customer_id = t.owner_id
    WHERE u.tenure_months > 0                              -- Prevent division by zero
)

-- Step 4: Return customer data sorted by estimated CLV
SELECT * FROM clv_calc
ORDER BY estimated_clv DESC;
