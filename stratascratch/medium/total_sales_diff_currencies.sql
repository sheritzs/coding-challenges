-- You work for a multinational company that wants to calculate 
-- total sales across all their countries they do business in.
-- You have 2 tables, one is a record of sales for all countries
--  and currencies the company deals with, and the other holds 
-- currency exchange rate information.
-- Calculate the total sales, per quarter, for the first 2 quarters 
-- in 2020, and report the sales in USD currency.

SELECT 
    EXTRACT(QUARTER FROM sales_date) AS quarter,
    SUM(sa.sales_amount * er.exchange_rate) AS total_sales
FROM sf_sales_amount sa LEFT JOIN sf_exchange_rate er
    ON sa.sales_date = er.date AND sa.currency = er.source_currency
WHERE EXTRACT(QUARTER FROM sales_date) <= 2 
GROUP BY EXTRACT(QUARTER FROM sales_date)
ORDER BY quarter

