--------------------------------------------------------------------------------
--                            Drop Existing Tables                            --
--------------------------------------------------------------------------------
DROP TABLE "D_CUSTOMERS";
DROP TABLE "D_PRODUCTS";
DROP TABLE "D_STORES";
DROP TABLE "D_SUPPLIERS";
DROP TABLE "D_TIME";
DROP TABLE "W_FACTS";
commit;
--------------------------------------------------------------------------------
--                          DDL for D_CUSTOMERS Table                         --
--------------------------------------------------------------------------------
CREATE TABLE D_CUSTOMERS
  ( CUSTOMER_ID     VARCHAR2(4), 
    CUSTOMER_NAME   VARCHAR2(30),
    CONSTRAINT "DCUSTOMERS_PK" PRIMARY KEY (CUSTOMER_ID) ENABLE
  );
commit; 

--------------------------------------------------------------------------------
--                          DDL for D_PRODUCTS Table                          --
--------------------------------------------------------------------------------
CREATE TABLE D_PRODUCTS
  ( PRODUCT_ID      VARCHAR2(6), 
    PRODUCT_NAME    VARCHAR2(30), 
    CONSTRAINT "DPRODUCTS_PK" PRIMARY KEY (PRODUCT_ID) ENABLE
  );
commit; 

--------------------------------------------------------------------------------
--                           DDL for D_STORES Table                           --
--------------------------------------------------------------------------------
CREATE TABLE D_STORES
  ( STORE_ID      VARCHAR2(4), 
    STORE_NAME    VARCHAR2(20),
    CONSTRAINT "DSTORES_PK" PRIMARY KEY (STORE_ID) ENABLE
  );
commit;

--------------------------------------------------------------------------------
--                          DDL for D_SUPPLIERS Table                         --
--------------------------------------------------------------------------------
CREATE TABLE D_SUPPLIERS
  ( SUPPLIER_ID     VARCHAR2(5), 
    SUPPLIER_NAME   VARCHAR2(30),
    CONSTRAINT "DSUPPLIERS_PK" PRIMARY KEY (SUPPLIER_ID) ENABLE
  );
commit;

--------------------------------------------------------------------------------
--                            DDL for D_TIME Table                            --
--------------------------------------------------------------------------------
CREATE TABLE D_TIME
  ( TIME_ID       VARCHAR2(8),
    CAL_DATE      DATE,
    CAL_DAY       VARCHAR2(9),
    CAL_MONTH     VARCHAR2(9),
    CAL_QUARTER   VARCHAR2(1),
    CAL_YEAR      NUMBER(4,0),
    CONSTRAINT "DTIME_PK" PRIMARY KEY (TIME_ID) ENABLE
  );
commit;

--------------------------------------------------------------------------------
--                            DDL for W_FACTS Table                           --
--------------------------------------------------------------------------------
CREATE TABLE W_FACTS
  ( TRANSACTION_ID  NUMBER(8,0), 
    CUSTOMER_ID     VARCHAR2(4), 
    PRODUCT_ID      VARCHAR2(6), 
    STORE_ID        VARCHAR2(4), 
    SUPPLIER_ID     VARCHAR2(5),
    TIME_ID         VARCHAR2(8), 
    QUANTITY        NUMBER(3,0),
    PRICE           NUMBER(5,2),
    SALE            NUMBER(6,2),
    CONSTRAINT "WFACTS_PK"      PRIMARY KEY (TRANSACTION_ID) ENABLE,
    CONSTRAINT "WCUSTOMERS_FK"  FOREIGN KEY (CUSTOMER_ID)
                                        REFERENCES  D_CUSTOMERS(CUSTOMER_ID)
                                        ENABLE,
    CONSTRAINT "WPRODUCTS_FK"   FOREIGN KEY (PRODUCT_ID)
                                        REFERENCES  D_PRODUCTS(PRODUCT_ID)
                                        ENABLE,
    CONSTRAINT "WSTORES_FK"     FOREIGN KEY (STORE_ID)
                                        REFERENCES  D_STORES(STORE_ID)
                                        ENABLE,
    CONSTRAINT "WSUPPLIERS_FK"  FOREIGN KEY (SUPPLIER_ID)
                                        REFERENCES  D_SUPPLIERS(SUPPLIER_ID)
                                        ENABLE,
    CONSTRAINT "WTIME_FK"       FOREIGN KEY (TIME_ID)
                                        REFERENCES  D_TIME(TIME_ID)
                                        ENABLE
  );
 commit; 