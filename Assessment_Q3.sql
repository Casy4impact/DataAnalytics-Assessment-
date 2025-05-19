-- Q3: Account Inactivity Alert
-- Goal:

-- Find plans or savings with no transactions in the last 365 days

-- Only show active accounts
-- Assessment_Q3.sql

-- Step 1: Get the most recent transaction date for each plan
WITH last_tx AS (
    SELECT 
        plan_id,
        owner_id,
        MAX(transaction_date) AS last_transaction_date       -- Get the last transaction date per plan and customer
    FROM savings_savingsaccount
    GROUP BY plan_id, owner_id
),

-- Step 2: Identify plans with no transactions in the last 365 days
inactive AS (
    SELECT 
        l.plan_id,
        l.owner_id,
        'Savings' AS type,                                   -- Label type for output clarity
        l.last_transaction_date,
        DATEDIFF(CURDATE(), l.last_transaction_date) AS inactivity_days -- Days since last transaction
    FROM last_tx l
    WHERE DATEDIFF(CURDATE(), l.last_transaction_date) > 365 -- Filter only those inactive for more than a year
)

-- Step 3: Output the inactive savings plans
SELECT * FROM inactive;
