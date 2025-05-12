/*
===============================================================================
Script: Data Quality Validation – Gold Layer
===============================================================================

Purpose:
    This script performs comprehensive data quality validations on the Gold layer 
    of the data warehouse to ensure the integrity, consistency, and accuracy 
    of analytical datasets.

    The validations include:
    - Ensuring uniqueness of surrogate keys in dimension tables.
    - Verifying referential integrity between fact and corresponding dimension tables.
    - Validating logical relationships across tables to support accurate reporting and insights.

Usage:
    - Execute this script after Gold layer views or tables are created and loaded.
    - Review and resolve any discrepancies or violations identified during the checks.

===============================================================================
*/

-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================
-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No results 
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.product_key'
-- ====================================================================
-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No results 
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
