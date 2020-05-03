/*  1. Which product generated maximum sales in September, 2017?              */
SELECT * FROM ( SELECT D_PRODUCTS.PRODUCT_NAME AS "PRODUCT NAME", 
                       SUM(CASE WHEN D_TIME.CAL_MONTH = 'SEP' 
                            THEN W_FACTS.SALE END) AS "SALE",
                       RANK() OVER 
                              (ORDER BY SUM(CASE WHEN D_TIME.CAL_MONTH = 'SEP' 
                                            THEN W_FACTS.SALE END) DESC) 
                              AS "RANK"
                FROM W_FACTS , D_TIME, D_PRODUCTS
                  WHERE W_FACTS.TIME_ID    = D_TIME.TIME_ID
                    AND W_FACTS.PRODUCT_ID = D_PRODUCTS.PRODUCT_ID
                GROUP BY D_PRODUCTS.PRODUCT_NAME
                ORDER BY "RANK"
              )
WHERE "RANK"=1
;

/*  2. Determine top three supplier names based on highest product sales.     */
SELECT * FROM ( SELECT RANK() OVER (ORDER BY SUM(W_FACTS.SALE) DESC) AS "RANK",
                       D_SUPPLIERS.SUPPLIER_NAME AS "SUPPLIER NAME", 
                       SUM(W_FACTS.SALE) AS "SALE"
                FROM W_FACTS, D_SUPPLIERS 
                  WHERE W_FACTS.SUPPLIER_ID = D_SUPPLIERS.SUPPLIER_ID
                GROUP BY W_FACTS.SUPPLIER_ID, D_SUPPLIERS.SUPPLIER_NAME
                ORDER BY "RANK"
              )
WHERE "RANK"<4
;

/*  3. Determine the top 3 stores who generated highest sales in SEP 2017.    */
SELECT * FROM ( SELECT RANK() OVER 
                              (ORDER BY SUM(CASE WHEN D_TIME.CAL_MONTH = 'SEP' 
                                      THEN W_FACTS.SALE END) DESC) AS "RANK",
                       D_STORES.STORE_NAME AS "STORE NAME", 
                       SUM(CASE WHEN D_TIME.CAL_MONTH = 'SEP' 
                           THEN W_FACTS.SALE END) AS "SALE"
                FROM W_FACTS, D_TIME, D_STORES
                  WHERE W_FACTS.TIME_ID  = D_TIME.TIME_ID
                    AND W_FACTS.STORE_ID = D_STORES.STORE_ID
                GROUP BY D_STORES.STORE_NAME
                         ORDER BY "RANK"
              )
WHERE "RANK"<4
;

/*  4. Presents the quarterly sales analysis for all stores using drill down 
       query concepts.                                                        */
SELECT  STORE_NAME AS "STORE NAME",
        SUM(CASE WHEN Q=1 THEN TOTAL END) AS "Q1_2017",
        SUM(CASE WHEN Q=2 THEN TOTAL END) AS "Q2_2017",
        SUM(CASE WHEN Q=3 THEN TOTAL END) AS "Q3_2017",
        SUM(CASE WHEN Q=4 THEN TOTAL END) AS "Q4_2017"
FROM 
    ( SELECT  D_STORES.STORE_NAME, D_TIME.CAL_QUARTER AS Q,
              SUM(W_FACTS.SALE) AS TOTAL
      FROM W_FACTS, D_STORES, D_TIME
        WHERE W_FACTS.STORE_ID = D_STORES.STORE_ID
          AND W_FACTS.TIME_ID = D_TIME.TIME_ID
      GROUP BY D_STORES.STORE_NAME, D_TIME.CAL_QUARTER
    )
GROUP BY STORE_NAME
ORDER BY STORE_NAME
;

/*  5. Create a materialised view with name “STORE_PRODUCT_ANALYSIS” that 
       presents store and product wise sales. 
       The results should be ordered by store name and then product name.     */
-- Drop any existing MV
DROP materialized VIEW STORE_PRODUCT_ANALYSIS;
-- Create MV
CREATE materialized VIEW STORE_PRODUCT_ANALYSIS 
AS
SELECT D_STORES.STORE_NAME AS "STORE NAME", 
       D_PRODUCTS.PRODUCT_NAME AS "PRODUCT NAME",
       SUM(W_FACTS.SALE) AS "SALE"
FROM W_FACTS, D_STORES, D_PRODUCTS
WHERE W_FACTS.STORE_ID = D_STORES.STORE_ID
  AND W_FACTS.PRODUCT_ID = D_PRODUCTS.PRODUCT_ID
GROUP BY D_STORES.STORE_NAME, D_PRODUCTS.PRODUCT_NAME
;
-- Display MV
SELECT * FROM STORE_PRODUCT_ANALYSIS
ORDER BY "STORE NAME" ASC, "PRODUCT NAME" ASC
;

/*  6. Create a materialised view with name “MONTH_STORE_ANALYSIS” that presents 
       month and store wise sales. 
       The results should be ordered by month name and then store name.       */
-- Drop any existing MV
DROP materialized VIEW MONTH_STORE_ANALYSIS;
-- Create MV
CREATE materialized VIEW MONTH_STORE_ANALYSIS 
AS
SELECT D_TIME.CAL_MONTH AS "MONTH",
       D_STORES.STORE_NAME AS "STORE NAME", 
       SUM(W_FACTS.SALE) AS "SALE"
FROM W_FACTS, D_STORES, D_TIME
WHERE W_FACTS.STORE_ID = D_STORES.STORE_ID
  AND W_FACTS.TIME_ID = D_TIME.TIME_ID
GROUP BY D_STORES.STORE_NAME, D_TIME.CAL_MONTH
;
-- Display MV
SELECT * FROM MONTH_STORE_ANALYSIS
ORDER BY "MONTH" ASC, "STORE NAME" ASC
;