# Supply Chain Analytics Dashboard

SQL, Excel, and Power BI analysis of a 180,519-row supply chain dataset — five
business questions, answered and cross-validated across all three tools.

## Dataset

DataCo Smart Supply Chain dataset (Constante, Silva, Pereira — 2019, Mendeley
Data). 180,519 order-item records, Jan 2015 – Jan 2018, across 5 markets / 23
regions. `sample_data_first_500_rows.csv` in this repo is a small sample for
quick inspection — the full dataset is publicly available on Mendeley Data /
Kaggle under the same name.

## Tools and files in this repo

| Tool | File(s) | What it does |
|---|---|---|
| **SQL** (MySQL) | `queries.sql` | Full query layer answering all 5 questions |
| **Excel** | `Supply_Chain_Dashboard_GitHub.xlsx` | Pivot tables + charts, one sheet per question |
| **Power BI** | Dashboard PDF export | Interactive dashboard: 4 KPI cards + 5 linked visuals |
| **Documentation** | `project_log.md` / `project_log.pdf` | Full step-by-step reasoning, SQL, results, and conclusions for every question |

## The five business questions and headline findings

**1. Does a faster shipping mode actually deliver more reliably?**
First Class shipments are late 95.3% of the time vs. 38.1% for Standard
Class. Root cause: 100% of First Class orders are scheduled for a 1-day
delivery window — the promise itself is unrealistic, not a fulfillment
failure.

**2. Do top-revenue product categories also drive the most profit?**
Top 15 categories by revenue sit at a flat ~10-13% margin. A few smaller
categories (Golf Bags & Carts, Soccer, Fitness Accessories) show noticeably
higher margins (~15-17%) — worth investigating for a replicable cost/pricing
structure.

**3. Which regions combine high late-delivery risk with low profit margin?**
Neither metric varies much by region (48-58% late rate, 10-13% margin across
all ~23 regions) — region is not a major driver of either problem, which
reinforces that shipping mode (Q1) and category (Q2) are the real levers.

**4. How do order volume and profit trend over 2015-2017?**
Order volume is stable (~4,800-5,400/month) from Jan 2015 through Sep 2017.
The final four months of the dataset (Oct 2017 - Jan 2018) were investigated
and excluded as a likely data-completeness issue rather than a real business
decline — confirmed via a min/max date check and unstable profit-per-order in
that window.

**5. Does discounting correlate with higher sales volume or profit ratio?**
Average order value stays flat (~₹203-204) regardless of discount rate —
discounting does not drive bigger orders. Profit margin declines steadily
from ~13% (no discount) to ~9% (20%+ discount). Tested for correlation vs.
causation by isolating individual categories — the pattern holds cleanly for
high-volume categories and gets noisy for low-volume ones due to small
sample sizes per discount bucket.

## Process notes worth mentioning

Every finding above was independently reproduced in SQL, Excel, and Power
BI — not just calculated once and assumed correct. A few real issues were
hit and fixed along the way (documented in full in `project_log.md`):
- A bulk CSV load into MySQL that silently failed at 356 rows before being
  fixed with a proper `LOAD DATA INFILE` command
- Columns misread as text instead of numbers in both Excel and Power BI,
  caught via type-checking before trusting any calculation
- A data-completeness anomaly in the final 4 months of the dataset, tested
  and confirmed rather than assumed

## Full write-up

See `project_log.md` (or the PDF) for the complete reasoning behind every
query, every chart, and every conclusion above.
