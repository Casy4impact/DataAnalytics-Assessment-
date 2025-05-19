-- Solutions Overview with Beginner-Friendly Guidance

-- Q1: High-Value Customers with Multiple Products
-- Goal: Customers who have:
-- At least 1 funded savings plan → is_regular_savings = 1
-- At least 1 funded investment plan → is_a_fund = 1
-- Join with savings data (confirmed_amount)
-- Output: customer name, counts, total deposits

-- Assessment_Q1.sql

-- Select users who have both a funded savings plan and a funded investment plan
SELECT 
    u.id AS owner_id,                         -- Customer's unique ID
    u.name,                                   -- Customer's name
    COUNT(DISTINCT s.id) AS savings_count,    -- Count of distinct savings transactions
    COUNT(DISTINCT p.id) AS investment_count, -- Count of distinct investment plans
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits -- Sum of all confirmed deposit amounts, converted from kobo to Naira
FROM users_customuser u
-- Join savings account table to get customer deposits
JOIN savings_savingsaccount s ON s.owner_id = u.id
-- Join plans table to get information about their savings and investment plans
JOIN plans_plan p ON p.owner_id = u.id
-- Only include savings linked to the specific plan
WHERE s.plan_id = p.id
  -- Ensure the plan is a savings account (is_regular_savings = 1)
  AND p.is_regular_savings = 1
  -- Ensure the plan is also an investment (is_a_fund = 1)
  AND p.is_a_fund = 1
GROUP BY u.id, u.name
-- Only include customers who have at least 1 savings and 1 investment plan
HAVING savings_count >= 1 AND investment_count >= 1
-- Sort the results so the customer with the highest deposit comes first
ORDER BY total_deposits DESC;


-- Key Clarifications
-- ROUND(SUM(...)/100, 2): Converts from kobo to Naira (since confirmed_amount is in kobo) and formats it to 2 decimal places.

-- HAVING: This filters the grouped results after aggregation. WHERE cannot be used with aggregate functions like COUNT().

-- DISTINCT: Prevents counting the same savings or plan multiple times for the same user