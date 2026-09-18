-- ============================================================
-- Supply Chain Analytics Project — SQL Query Layer (MySQL)
-- Database: supply_chain | Table: orders
-- Dataset: DataCo Smart Supply Chain (180,519 order-items, 2015-2017)
-- ============================================================

-- Q1: Late delivery rate by shipping mode
SELECT
    `Shipping Mode`,
    COUNT(*) AS total_orders,
    ROUND(AVG(Late_delivery_risk) * 100, 1) AS late_pct,
    ROUND(AVG(shipping_delay_days), 2) AS avg_delay_days
FROM orders
GROUP BY `Shipping Mode`
ORDER BY late_pct DESC;

-- Q2: Revenue vs profit by product category (top 10 by revenue)
SELECT
    `Category Name`,
    ROUND(SUM(Sales), 0) AS total_revenue,
    ROUND(SUM(`Order Profit Per Order`), 0) AS total_profit,
    ROUND(SUM(`Order Profit Per Order`) * 100.0 / NULLIF(SUM(Sales), 0), 1) AS profit_margin_pct
FROM orders
GROUP BY `Category Name`
ORDER BY total_revenue DESC
LIMIT 10;

-- Q3: Region performance — late delivery risk vs profit margin
SELECT
    `Order Region`,
    COUNT(*) AS total_orders,
    ROUND(AVG(Late_delivery_risk) * 100, 1) AS late_pct,
    ROUND(SUM(`Order Profit Per Order`) * 100.0 / NULLIF(SUM(Sales), 0), 1) AS profit_margin_pct
FROM orders
GROUP BY `Order Region`
ORDER BY late_pct DESC, profit_margin_pct ASC;

-- Q4: Monthly order volume and profit trend
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS order_count,
    ROUND(SUM(Sales), 0) AS total_sales,
    ROUND(SUM(`Order Profit Per Order`), 0) AS total_profit
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- Q5: Discount rate buckets vs avg sales per order and profit ratio
SELECT
    CASE
        WHEN `Order Item Discount Rate` = 0 THEN '0% (no discount)'
        WHEN `Order Item Discount Rate` <= 0.1 THEN '0-10%'
        WHEN `Order Item Discount Rate` <= 0.2 THEN '10-20%'
        ELSE '20%+'
    END AS discount_bucket,
    COUNT(*) AS order_count,
    ROUND(AVG(Sales), 2) AS avg_sales_per_order,
    ROUND(AVG(`Order Item Profit Ratio`), 3) AS avg_profit_ratio
FROM orders
GROUP BY discount_bucket
ORDER BY discount_bucket;
