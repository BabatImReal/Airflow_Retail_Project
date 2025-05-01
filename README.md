Overview
========

Welcome to Astronomer! This project was generated after you ran 'astro dev init' using the Astronomer CLI. This readme describes the contents of the project, as well as how to run Apache Airflow on your local machine.

Project Contents
================

Your Astro project contains the following files and folders:

- dags: This folder contains the Python files for your Airflow DAGs. By default, this directory includes one example DAG:
    - `example_astronauts`: This DAG shows a simple ETL pipeline example that queries the list of astronauts currently in space from the Open Notify API and prints a statement for each astronaut. The DAG uses the TaskFlow API to define tasks in Python, and dynamic task mapping to dynamically print a statement for each astronaut. For more on how this DAG works, see our [Getting started tutorial](https://www.astronomer.io/docs/learn/get-started-with-airflow).
- Dockerfile: This file contains a versioned Astro Runtime Docker image that provides a differentiated Airflow experience. If you want to execute other commands or overrides at runtime, specify them here.
- include: This folder contains any additional files that you want to include as part of your project. It is empty by default.
- packages.txt: Install OS-level packages needed for your project by adding them to this file. It is empty by default.
- requirements.txt: Install Python packages needed for your project by adding them to this file. It is empty by default.
- plugins: Add custom or community plugins for your project to this file. It is empty by default.
- airflow_settings.yaml: Use this local-only file to specify Airflow Connections, Variables, and Pools instead of entering them in the Airflow UI as you develop DAGs in this project.

Deploy Your Project Locally
===========================

Start Airflow on your local machine by running 'astro dev start'.

This command will spin up five Docker containers on your machine, each for a different Airflow component:

- Postgres: Airflow's Metadata Database
- Scheduler: The Airflow component responsible for monitoring and triggering tasks
- DAG Processor: The Airflow component responsible for parsing DAGs
- API Server: The Airflow component responsible for serving the Airflow UI and API
- Triggerer: The Airflow component responsible for triggering deferred tasks

When all five containers are ready the command will open the browser to the Airflow UI at http://localhost:8080/. You should also be able to access your Postgres Database at 'localhost:5432/postgres' with username 'postgres' and password 'postgres'.

Note: If you already have either of the above ports allocated, you can either [stop your existing Docker containers or change the port](https://www.astronomer.io/docs/astro/cli/troubleshoot-locally#ports-are-not-available-for-my-local-airflow-webserver).

Deploy Your Project to Astronomer
=================================

If you have an Astronomer account, pushing code to a Deployment on Astronomer is simple. For deploying instructions, refer to Astronomer documentation: https://www.astronomer.io/docs/astro/deploy-code/

Contact
=======

The Astronomer CLI is maintained with love by the Astronomer team. To report a bug or suggest a change, reach out to our support.

# Retail_Airflow_Project

Welcome to the **Retail Airflow Project** powered by **Astronomer**! This project is designed to manage and orchestrate data workflows for retail operations using **Apache Airflow**, integrated with **DBT** for data transformations and **Soda** for data quality checks. This README outlines the project structure and how to run it locally using the Astronomer CLI.

---

## 📁 Project Contents

Your Astro project contains the following key components:

- **`dags/`**: Contains your Airflow DAGs. You can place your retail-specific DAGs here. Currently includes an example DAG:
  - `example_astronauts.py`: Sample ETL DAG using TaskFlow API and dynamic task mapping (can be removed or replaced).
- **`include/`**: Place any custom scripts, DBT models, Soda checks, or assets here.
  - Suggested layout:
    - `include/dbt/models/`: DBT SQL models for retail transformations.
    - `include/soda/checks/`: YAML files with Soda data quality checks.
- **`plugins/`**: Add custom or community Airflow plugins here.
- **`Dockerfile`**: Defines the runtime environment based on the Astro Runtime image.
- **`packages.txt`**: Install system-level dependencies (optional).
- **`requirements.txt`**: Python dependencies for DBT, Soda, or any custom logic.
- **`airflow_settings.yaml`**: Define Airflow Connections, Variables, and Pools locally.
- **`.env`** (optional): Store environment-specific variables, such as GCP credentials or API keys (ignored by Git).

---

## 🧑‍💻 Running Airflow Locally

To start Airflow with Astronomer:

```bash
astro dev start
```

---

## DBT Integration
To run DBT models inside your project:
```bash
cd include/dbt
dbt run
```
Ensure that both profiles.yml and dbt_project.yml are configured properly in the include/dbt/ directory.

---

## 📦 DBT Integration
DBT (Data Build Tool) is used for transforming your raw data into clean, structured data. To integrate DBT into your project:

### 1.Install DBT dependencies in your local environment:

```bash
pip install dbt
```
## 2.Configure DBT:

- Navigate to the include/dbt/ directory in the project.
- Configure the profiles.yml and dbt_project.yml files to match your data warehouse credentials and project settings.

## 3.Run DBT Models:

In the include/dbt/ directory, run the following command to execute the transformations defined in your DBT models:

```bash
astro dev bash
source /usr/local/airflow/dbt_venv/bin/activate
cd include/dbt 
dbt deps
dbt run --profiles-dir /usr/local/airflow/include/dbt/
```
This command will execute the transformations for all the models defined in your DBT project.

Check DBT Logs:

After running DBT, check the logs to ensure the models ran successfully. Logs are typically located in the logs/ directory, and any errors during execution will be printed there.

Make sure that your data warehouse is set up and accessible from the environment where you're running DBT.

---

## Soda Integration for Data Quality Monitoring
Soda is a tool that helps ensure data quality by checking for issues such as missing values, duplicates, and inconsistencies in your data warehouse. Follow the steps below to integrate and run Soda in your project.

### 1. Install Soda Dependencies
To use Soda, you need to install its dependencies in your local environment:

``` bash
pip install soda-sql
```
### 2. Configure Soda
Once Soda is installed, you need to set up the necessary configuration files:
- Place your data quality checks in the include/soda/checks/ directory.
- Create a configuration file (soda_config.yml) in the include/soda/ directory. Ensure this file contains the correct connection details for your data warehouse.

### 3. Run Soda Data Quality Checks
To scan your data for quality issues, navigate to the include/soda/ directory and run the following command:
```bash
cd /usr/local/airflow
source /usr/local/airflow/soda_venv/bin/activate
soda scan -d retail -c include/soda/configuration.yml include/soda/checks/report/*
```
This command will initiate the scan and check your data for any quality issues.

### 4. Review Soda Results
Once the scan is complete, review the results outputted in the terminal. Soda will provide feedback on any data quality issues it finds. Use this feedback to troubleshoot and fix any issues in your data warehouse.
























