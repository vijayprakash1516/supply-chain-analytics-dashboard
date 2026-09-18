# Supply Chain Analytics Project — Starter Package

## Source
DataCo Smart Supply Chain dataset (Constante, Silva, Pereira — 2019, Mendeley Data).
180,519 order-item records, 2015-01 to 2017-09, across 5 markets / 23 regions.

## Files
- `supply_chain_cleaned.csv` — cleaned dataset (PII columns removed, dates parsed,
  `shipping_delay_days` derived column added). This is the file loaded into MySQL,
  and the same file to import into Excel and Power BI.
- `queries.sql` — the 5 core queries answering the business questions below,
  written in MySQL syntax (backtick-quoted column names).

## Database setup (MySQL Workbench)
1. Schema: `supply_chain`
2. Table: `orders` — created via Table Data Import Wizard, then loaded properly
   using `LOAD DATA INFILE` (the wizard alone is unreliable on large CSVs — it
   silently stopped at 356 rows before the full load was done correctly).
3. The CSV has a few rows with missing `Customer Zipcode` values, which trips
   MySQL's strict mode by default. Fix applied: `SET SESSION sql_mode = '';`
   before running the load, so those few rows load with a null zip code instead
   of aborting the whole import.
4. Full load command used:
   ```sql
   LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/supply_chain_cleaned.csv'
   INTO TABLE supply_chain.orders
   FIELDS TERMINATED BY ','
   ENCLOSED BY '"'
   LINES TERMINATED BY '\n'
   IGNORE 1 ROWS;
   ```
5. Verified row count: `SELECT COUNT(*) FROM supply_chain.orders;` → 180519

## Business Questions (Q1-Q5)
1. Does a faster shipping mode actually deliver more reliably?
2. Do top-revenue product categories also drive the most profit?
3. Which regions combine high late-delivery risk with low profit margin?
4. How do order volume and profit trend over 2015-2017?
5. Does discounting correlate with higher sales volume or profit ratio?

## Key findings so far (from the SQL layer)
- First Class shipments are late 95.3% of the time vs 38.1% for Standard Class —
  shipping mode is a far stronger predictor of lateness than region or market.
- Regional late-delivery rates are comparatively flat (55-58% across the worst regions).
- Top-revenue categories (Fishing, Cleats, Camping & Hiking) all sit in a narrow
  10-11% profit margin band — no major revenue/profit mismatch among leaders.
- Discount rate has ~zero correlation with profit ratio or average order value —
  discounting isn't clearly moving the needle either way.

## Next steps
1. Finish writing and running Q1-Q5 in MySQL Workbench (in progress).
2. Import `supply_chain_cleaned.csv` into Excel. Build pivot tables for the ABC
   analysis (category/vendor revenue contribution) and a shipping-mode scorecard.
3. Import the same CSV into Power BI. Build the shipping-mode reliability visual
   as your headline chart — it's the strongest, most specific finding.
4. Write the 1-page insight summary once your visuals are built.
