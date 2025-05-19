-- Q2: Transaction Frequency Analysis
-- Goal:

-- Count transactions per customer per month

-- Categorize: High (≥10), Medium (3–9), Low (≤2)
-- Assessment_Q2.sql

-- Step 1: Calculate number of transactions per customer per month
WITH monthly_tx AS (
    SELECT 
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS year_month, -- Format date as 'YYYY-MM' for monthly grouping
        COUNT(*) AS tx_count                                 -- Count transactions for that month
    FROM savings_savingsaccount
    GROUP BY owner_id, year_month
),

-- Step 2: Compute average transactions per customer per month
avg_tx AS (
    SELECT 
        owner_id,
        AVG(tx_count) AS avg_tx_per_month                    -- Calculate average of monthly transaction counts
    FROM monthly_tx
    GROUP BY owner_id
),

-- Step 3: Categorize each customer based on average monthly transaction
categorized AS (
    SELECT 
        CASE 
            WHEN avg_tx_per_month >= 10 THEN 'High Frequency'     -- High: 10 or more
            WHEN avg_tx_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency' -- Medium: 3 to 9
            ELSE 'Low Frequency'                                  -- Low: 2 or fewer
        END AS frequency_category,
        avg_tx_per_month
    FROM avg_tx
)

-- Step 4: Aggregate the count of customers in each category and average their transaction frequency
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,                             -- Total customers in each category
    ROUND(AVG(avg_tx_per_month), 1) AS avg_transactions_per_month -- Overall average per category
FROM categorized
GROUP BY frequency_category;
