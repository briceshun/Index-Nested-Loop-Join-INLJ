# Index Nested Loop Join (INLJ)
This project is about building and analysing a Data Warehouse prototype for New World with a Semi Stream Join (INLJ) implementation.

## Operating the Data Warehouse
The operation of the data warehouse can be broken down into 3 major steps:
1) Creation of the Data Warehouse.
2) Extraction, Transformation, and Loading using the INLJ algorithm.
3) Creation of Reports using OLAP Queries.

## Requirements
The `CUSTOMERS`, `PRODUCTS`, and `TRANSACTIONS` tables should already be loaded in the database.

## Step 1: Create Data Warehouse
1) Open *SQLDeveloper*.
2) Run the SQL script file *createDW.sql* which will create the necessary tables for the data warehouse according to the star-schema.
   All existing tables with the same name will be dropped and replaced by empty tables named
   `D_CUSTOMERS`, `D_PRODUCTS`, `D_STORES`, `D_SUPPLIERS`, and `D_TIME` (dimension tables); and `W_FACTS` (fact table).

Once completed, the above **6** tables would have been created.

## Step 2: Extraction, Transformation, & Loading Using The INLJ Algorithm
1) With *SQLDeveloper* open, open and run the *INLJ.sql* PL-SQL file which will implement the INLJ algorithm.
2) The algorithm involves the creation of the `TRANSACTIONSCURSOR` which is a cursor that will be used to read the tuples from the `TRANSACTIONS` table.
3) The `BULK COLLECT...LIMIT=100` statement limits the number of tuples per batch read to **100**.
4) It is possible to change this by replacing the number "100" by any number less than the total number of records in the `TRANSACTIONS` table.

Once completed, the script would have loaded the data in the relevant Data Warehouse tables.

## Step 3: Creation of Reports using OLAP Queries
1) With *SQLDeveloper* open, select which report is to be created.
2) Select the lines relevant to the report to be created - the file contains separations between each query.
3) Select the lines from the comment denoted by `/*....*/` to the end of the code which is denoted by a `;` and precedes another comment denoting the lines used to generate the next report.
