# SQL UTM Campaign Analysis

## Overview

This project focuses on analyzing digital advertising data from Facebook Ads and Google Ads using PostgreSQL.

The project uses SQL techniques to combine advertising data, extract UTM campaign parameters, handle missing values, and calculate key marketing performance metrics.

## Objectives

- Combine Facebook Ads and Google Ads data using CTEs and UNION.
- Handle NULL values using COALESCE.
- Extract UTM campaign parameters from URL strings.
- Convert UTM campaign values to lowercase.
- Replace 'nan' values with NULL.
- Calculate advertising performance metrics.
- Prevent division-by-zero errors using CASE expressions.

## SQL Concepts

- Common Table Expressions (CTEs)
- UNION
- String Functions (LOWER, SUBSTRING)
- Regular Expressions (Regex)
- COALESCE
- CASE WHEN
- NULL Handling
- Aggregate Functions (SUM)
- GROUP BY and ORDER BY

## Key Metrics

- Total Spend
- Total Impressions
- Total Clicks
- Total Conversion Value
- CTR (Click-Through Rate)
- CPC (Cost Per Click)
- CPM (Cost Per 1,000 Impressions)
- ROMI (Return on Marketing Investment)

## Data Sources

- facebook_ads_basic_daily
- google_ads_basic_daily

## Tools

- PostgreSQL
- SQL

## Project Outcome

The project demonstrates how SQL string manipulation, conditional logic, and NULL handling can be used to prepare and analyze digital marketing campaign data.
