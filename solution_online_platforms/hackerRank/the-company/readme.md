# HackerRank SQL Challenge: The Company

This repository contains a solution to the HackerRank SQL challenge titled "The Company." The problem statement can be found at: [https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true](https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true).

## Problem Overview

In this challenge, the task is to analyze a company's hierarchy by writing a SQL query that retrieves the following information for each company:

- **Company Code**: The unique identifier for the company.
- **Founder**: Name of the company's founder.
- **Number of Lead Managers**: Total count of distinct lead managers.
- **Number of Senior Managers**: Total count of distinct senior managers.
- **Number of Managers**: Total count of distinct managers.
- **Number of Employees**: Total count of distinct employees.

The query should return the results sorted by `company_code` in ascending order.

## Approach

The problem can be approached in two ways:

### 1. Using Nested Joins to Build the Hierarchy

This approach involves:

- Constructing a Common Table Expression (CTE) or subquery (`company_hierarchy`) to combine all hierarchical relationships between tables.
- Applying multiple `LEFT JOIN` operations to link `Company`, `Lead_Manager`, `Senior_Manager`, `Manager`, and `Employee` tables.
- Counting distinct entries for each role in the hierarchy within the grouped results.

### 2. Using a Single Join with Predefined Relationships

This optimized approach involves:

- Directly joining the `Employee` table with the `Company` table.
- Leveraging the existing relationships within the `Employee` table, which contains hierarchy details (e.g., `lead_manager_code`, `senior_manager_code`, etc.).
- Counting distinct entries for each role directly from the `Employee` table.

## Key Comparisons

| Feature                   | Nested Joins Approach                                     | Optimized Single Join Approach                         |
|---------------------------|----------------------------------------------------------|-------------------------------------------------------|
| **Query Complexity**      | High - Involves multiple `LEFT JOIN` operations.         | Low - Uses a single `JOIN` with aggregated counts.    |
| **Performance**           | Lower - Joins may involve redundant operations.          | Higher - Minimal joins reduce execution time.         |
| **Readability**           | Moderate - Explicitly builds the hierarchy step-by-step. | High - Compact and easy to understand.               |
| **Scalability**           | Handles complex scenarios with additional hierarchy levels. | Best for straightforward use cases with predefined relationships. |

## Note

Both approaches produce the same results but differ in performance and complexity.


## Acknowledgments

- Thanks to HackerRank for providing this challenge. View the problem [here](https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true).

