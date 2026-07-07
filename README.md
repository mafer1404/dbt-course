# dbt Course - Airbnb Analytics

A dbt project built on Snowflake that models Airbnb listing, host, and review data. Developed as part of the Udemy Complete dbt Bootcamp.

## Project Structure

```
dbt/
  airbnb/           # Main dbt project
    models/
      src/          # Ephemeral staging models (source transformations)
      dim/          # Dimension tables (hosts, listings, full moon dates)
      fct/          # Fact tables (reviews)
      mart/         # Mart layer (business-facing aggregations)
    macros/         # Custom macros (schema generation, logging, tests)
    seeds/          # Static CSV data (full moon dates)
    snapshots/      # SCD Type 2 snapshots (hosts, listings)
    tests/          # Custom data tests
    analyses/       # Ad-hoc analytical queries
```

## Tech Stack

- **dbt Core** 1.11
- **Snowflake** (adapter: snowflake 1.11.6)
- **Packages:** dbt_utils, dbt_expectations

## Environments

| Target | Schema | Purpose |
|--------|--------|---------|
| dev | `DBT_<user>` | Local development |
| prod | `DBT_MYDEV` | Production build |

All credentials are managed via environment variables (no secrets in repo).

## Quick Start

```bash
# Activate virtual environment
source dbt-core/bin/activate

# Install dbt packages
dbt deps

# Run dev build
dbt build

# Run prod build
dbt build --target prod --profiles-dir=_prod_profiles
```

## Key Features

- **Incremental models** with microbatch strategy (fct_reviews, mart_fullmoon_reviews)
- **SCD Type 2 snapshots** for hosts and listings history
- **Data quality tests** using dbt_expectations (regex, distinct counts, quantiles)
- **Custom generic tests** (minimum row count, positive values)
- **Audit logging** via on-run-start hook and post-hook
- **Role-based grants** (transform, reporter)
- **Unit tests** for mart logic
