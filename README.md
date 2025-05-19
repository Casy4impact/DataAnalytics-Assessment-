# DataAnalytics-Assessment-
# Data Analytics SQL Assessment

## Overview

- This repository contains my solutions to the Data Analyst SQL Proficiency Assessment. It includes four SQL queries addressing business problems using real-world data structures.


## Questions and Explanations

### Q1: High-Value Customers with Multiple Products
- I identified users who have both savings and investment plans. I joined `users_customuser`, `plans_plan`, and `savings_savingsaccount`, filtered on `is_regular_savings = 1` and `is_a_fund = 1`, and aggregated confirmed savings.

### Q2: Transaction Frequency Analysis
- To categorize users by transaction activity, I counted monthly transactions, computed their average, and used CASE to segment into High/Medium/Low frequency groups.

### Q3: Account Inactivity Alert
- I flagged savings accounts with no transactions in the last 365 days. Used MAX transaction_date grouped by plan and owner.

### Q4: Customer Lifetime Value (CLV)
- I estimated CLV using the formula provided. I calculated tenure, total transactions, and average profit per transaction to compute and rank customers by CLV.


## Challenges

- Ensuring all foreign key relationships and data assumptions aligned correctly.
- Precision formatting for monetary values in kobo.
- Handling 0 tenure months to avoid division by zero in CLV.
