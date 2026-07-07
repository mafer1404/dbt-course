# Airbnb dbt Project

dbt project that transforms raw Airbnb data (listings, hosts, reviews) into analytics-ready models on Snowflake.

## Data Sources

All sources come from `AIRBNB.RAW`:

| Source Table | Description |
|-------------|-------------|
| `raw_listings` | Airbnb property listings with price, room type, minimum nights |
| `raw_hosts` | Host profiles with superhost status |
| `raw_reviews` | Guest reviews with sentiment and dates |

## Model Layers

### src/ (ephemeral)
Lightweight transformations on raw sources — renaming, type casting.

- `src_listings` - Cleaned listing fields
- `src_hosts` - Cleaned host fields
- `src_reviews` - Cleaned review fields

### dim/ (tables)
Dimension models with business logic applied.

- `dim_hosts_cleansed` / `dim_hosts_cleansed_v2` - Hosts with NULL handling
- `dim_listings_cleansed` - Listings with validated price and room type
- `dim_listings_w_hosts` - Listings joined with host info
- `dim_long_term_listings` - Filtered to listings with 30+ night minimum (Python model)
- `dim_fullmoon` - Full moon date dimension (Python model from seed)

### fct/ (incremental)
Fact models tracking events over time.

- `fct_reviews` - Reviews with sentiment, incrementally loaded by review_date

### mart/ (microbatch)
Business-facing aggregations.

- `mart_fullmoon_reviews` - Reviews correlated with full moon dates

## Snapshots (SCD Type 2)

- `scd_raw_hosts` - Tracks changes to host superhost status
- `scd_raw_listings` - Tracks changes to listing price and minimum nights

## Tests

- **Schema tests:** unique, not_null, accepted_values, relationships
- **dbt_expectations:** regex matching, distinct counts, quantile ranges, row count comparisons
- **Custom generic tests:** minimum_row_count, positive_values
- **Singular tests:** consistent_created_at, dim_listings_minimum_nights
- **Unit tests:** fullmoon matcher logic

## Macros

| Macro | Purpose |
|-------|---------|
| `generate_schema_name` | Custom schema naming for prod/dev |
| `logging` | Debug logging utilities |
| `no_empty_strings` | Test for empty string values |
| `no_nulls_in_columns` | Test all columns for NULLs |
| `select_positive_values` | Filter helper for positive value tests |
| `drop_dev_schemas` | Cleanup macro for dev schemas |
| `variables` | Project variable definitions |

## Running

```bash
# Full build (models + tests + snapshots + seeds)
dbt build

# Run specific model
dbt run --select fct_reviews

# Test only
dbt test

# Full refresh (rebuild incremental from scratch)
dbt build --full-refresh
```
