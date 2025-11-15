CREATE TABLE case_sale_analysis
(
  Sale_Id INT,
  Branch	VARCHAR,
  Category VARCHAR,
  Product VARCHAR,
  Quantity INT,
  Order_Date	DATE,
  Price MONEY
);

SELECT * FROM case_sale_analysis;

---Row count

SELECT COUNT(*) AS total_rows
FROM case_sale_analysis;

---Date range
SELECT 
    MIN(order_date) AS first_sale_date,
    MAX(order_date) AS last_sale_date
FROM case_sale_analysis;

---Summary statistics for numeric fields
SELECT 
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price,
    SUM(price) AS total_revenue,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    AVG(quantity) AS avg_quantity
FROM clean_sales;

---Daily sales totals
SELECT 
    order_date,
    SUM(price * quantity) AS daily_revenue,
    SUM(quantity) AS daily_items_sold,
    COUNT(*) AS transactions
FROM case_sale_analysis
GROUP BY order_date
ORDER BY order_date;

---Sales by weekday
SELECT 
    TO_CHAR(order_date, 'Day') AS weekday,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS items_sold,
    COUNT(*) AS transactions
FROM case_sale_analysis
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY total_revenue DESC;

---Monthly revenue
SELECT 
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS items_sold,
    COUNT(*) AS transactions
FROM case_sale_analysis
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

---Total revenue per branch
SELECT 
    branch,
    SUM(price * quantity) AS branch_revenue,
    SUM(quantity) AS items_sold
FROM case_sale_analysis
GROUP BY branch
ORDER BY branch_revenue DESC;

---Monthly revenue by branch
SELECT 
    branch,
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(price * quantity) AS revenue
FROM case_sale_analysis
GROUP BY branch, TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month, revenue DESC;

---Top categories by revenue
SELECT 
    category,
    SUM(price * quantity) AS category_revenue,
    SUM(quantity) AS items_sold
FROM case_sale_analysis
GROUP BY category
ORDER BY category_revenue DESC;

---Category performance by month
SELECT 
    category,
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(price * quantity) AS monthly_revenue
FROM case_sale_analysis
GROUP BY 1,2
ORDER BY month, monthly_revenue DESC;

---Top-selling products by revenue
SELECT 
    product,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_quantity
FROM case_sale_analysis
GROUP BY product
ORDER BY total_revenue DESC
LIMIT 20;

---Most frequently sold products
SELECT 
    product,
    COUNT(*) AS times_sold
FROM case_sale_analysis
GROUP BY product
ORDER BY times_sold DESC
LIMIT 20;

---Full Transaction Revenue
SELECT
    sale_id,
    branch,
    category,
    product,
    quantity,
    price,
    (quantity * price) AS total_transaction_value,
    order_date
FROM case_sale_analysis;

--- END OF THE PROPECT
