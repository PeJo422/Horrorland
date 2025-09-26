🎢 Horrorland dbt Sandbox

powered by dbt Fusion and Snowflake

Welcome to the Horrorland sandbox project! This repository provides a hands-on playground for learning dbt Fusion using fictional Horrorland amusement park data. It demonstrates dbt workflows, Snowflake integration, environment management via 1Password CLI, and CI/CD with SQLFluff linting.

🚀 Project Goal

Provide a safe environment to explore dbt Fusion transformations, snapshots, and models.

Demonstrate Snowflake integration and repository-driven variable configuration.

Showcase CI/CD pipelines, including SQLFluff linting for consistent SQL formatting.

🏗 Project Structure

models/ – Core dbt models (staging and transformations).

snapshots/ – One snapshot to demonstrate historical tracking.

seeds/ – Example CSVs used to load reference data.

All models use fictional Horrorland data, no sensitive information included.

⚙️ Prerequisites

Snowflake Trial Account – used for database, schema, and warehouse execution.

dbt Fusion installed – refer to the official dbt documentation for setup.

1Password CLI – manage environment secrets locally.

Python 3.11+ – for SQLFluff linting and dbt CLI commands.

🛠 Setup

Configure Snowflake connection in your local ~/.dbt/profiles.yml. Reference repository variables for warehouse, database, and schema.

Run dbt build to execute models, seeds, and snapshots:

dbt build


Lint SQL locally using SQLFluff:

sqlfluff lint models/
sqlfluff fix models/


SQLFluff ensures consistent formatting and helps prevent common syntax errors.

🧪 CI/CD

GitHub Actions runs SQLFluff linting on all pull requests to enforce consistent SQL formatting.

Any formatting or syntax issues detected in CI/CD will fail the pipeline, ensuring only clean SQL enters the repository.

💡 Tips

Use a VS Code Jinja-SQL setup for syntax highlighting:

{
  "files.associations": {
    "**/models/**/*.sql": "jinja-sql",
    "**/snapshots/**/*.sql": "jinja-sql",
    "**/macros/**/*.sql": "jinja-sql",
    "**/seeds/**/*.sql": "jinja-sql"
  }
}


Ensure a single trailing newline at the end of each SQL file for SQLFluff compliance.

For dbt learning resources, refer to dbt Learn
.

📚 Learning Objectives

Understand dbt Fusion project structure and workflow.

Explore staging, transformation models, and snapshot mechanics.

Practice maintaining clean SQL using SQLFluff locally and in CI/CD.

Demonstrate secure environment management with 1Password CLI.