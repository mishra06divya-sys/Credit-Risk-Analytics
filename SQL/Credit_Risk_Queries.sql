-- Credit Risk Analytics Project
-- SQL Analysis Queries
-- Dataset: credit_risk_final
-- Loan_Status: 0 = Non-Default, 1 = Default

-- =========================================================
-- Q1. Total number of customers/loans and total loan amount
-- =========================================================
SELECT
    COUNT(*) AS total_loans,
    SUM(Loan_amount) AS total_loan_amount
FROM credit_risk_final;


-- =========================================================
-- Q2. Overall loan default rate
-- =========================================================
SELECT
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) AS total_defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM credit_risk_final;


-- =========================================================
-- Q3. Which loan risk grade has the highest default rate?
-- =========================================================
SELECT
    Loan_risk_grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM credit_risk_final
GROUP BY Loan_risk_grade
ORDER BY default_rate DESC;


-- =========================================================
-- Q4. Which loan purpose has the most defaults?
-- =========================================================
SELECT
    Purpose_of_loan,
    SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) AS total_defaults
FROM credit_risk_final
GROUP BY Purpose_of_loan
ORDER BY total_defaults DESC;


-- =========================================================
-- Q5. Average loan amount by loan risk grade
-- =========================================================
SELECT
    Loan_risk_grade,
    ROUND(AVG(Loan_amount), 2) AS average_loan_amount
FROM credit_risk_final
GROUP BY Loan_risk_grade
ORDER BY Loan_risk_grade;


-- =========================================================
-- Q6. Average interest rate for defaulted vs non-defaulted loans
-- =========================================================
SELECT
    Loan_Status,
    CASE
        WHEN Loan_Status = 0 THEN 'Non-Default'
        WHEN Loan_Status = 1 THEN 'Default'
    END AS loan_status_label,
    ROUND(AVG(Interest_rate), 2) AS average_interest_rate
FROM credit_risk_final
GROUP BY Loan_Status
ORDER BY Loan_Status;


-- =========================================================
-- Q7. Default rate by income group
-- Income groups: Low < 30,000; Medium 30,000-60,000;
-- High > 60,000
-- =========================================================
SELECT
    CASE
        WHEN Customer_income < 30000 THEN 'Low'
        WHEN Customer_income <= 60000 THEN 'Medium'
        ELSE 'High'
    END AS income_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM credit_risk_final
GROUP BY
    CASE
        WHEN Customer_income < 30000 THEN 'Low'
        WHEN Customer_income <= 60000 THEN 'Medium'
        ELSE 'High'
    END
ORDER BY default_rate DESC;


-- =========================================================
-- Q8. Default rate by home ownership
-- =========================================================
SELECT
    Home_ownership,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM credit_risk_final
GROUP BY Home_ownership
ORDER BY default_rate DESC;


-- =========================================================
-- Q9. Default rate by age group
-- =========================================================
SELECT
    CASE
        WHEN Customer_Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Customer_Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Customer_Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END AS age_group,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate
FROM credit_risk_final
GROUP BY
    CASE
        WHEN Customer_Age BETWEEN 20 AND 29 THEN '20-29'
        WHEN Customer_Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Customer_Age BETWEEN 40 AND 49 THEN '40-49'
        ELSE '50+'
    END
ORDER BY default_rate DESC;


-- =========================================================
-- Q10. Final risk summary by loan risk grade
-- =========================================================
SELECT
    Loan_risk_grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) AS defaults,
    ROUND(
        100.0 * SUM(CASE WHEN Loan_Status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS default_rate,
    ROUND(AVG(Loan_amount), 2) AS average_loan_amount,
    ROUND(AVG(Interest_rate), 2) AS average_interest_rate
FROM credit_risk_final
GROUP BY Loan_risk_grade
ORDER BY Loan_risk_grade;
