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

--- write a query to retrieve the second highest price
SELECT *
FROM
(
    SELECT *,
    DENSE_RANK () OVER(ORDER BY price DESC) rank_no
    FROM case_sale_analysis
) as subquery
WHERE rank_no=2

--- write a query to get the details of thee sale for the second highest price from each category
 SELECT*
 FROM
 (
   SELECT*,
   DENSE_RANK() OVER(PARTITION BY category ORDER BY price DESC) AS RN
   FROM case_sale_analysis
  ) as subquery
  WHERE RN=2
 

