"""DAG that kicks off the pipeline by producing to the start dataset."""

# --------------- #
# Package imports #
# --------------- #

from airflow import Dataset
from airflow.decorators import dag
from airflow.operators.empty import EmptyOperator
from pendulum import datetime
from include import global_variables as gv

# -------------------- #
# Local module imports #
# -------------------- #


# -------- #
# Datasets #
# -------- #


# --- #
# DAG #
# --- #


@dag(
    start_date=datetime(2023, 1, 1),
    # after being unpaused this DAG will run once, afterwards it can be run
    # manually with the play button in the Airflow UI
    schedule="@daily",
    catchup=False,
    description="Run this DAG to start the pipeline!",
    tags=["start", "setup"],
)
def start_pipeline():

    # this task uses the BashOperator to run a bash command creating an Airflow
    # pool called 'duckdb' which contains one worker slot. All tasks running
    # queries against DuckDB will be assigned to this pool, preventing parallel
    # requests to DuckDB.
    start_pipeline = EmptyOperator(
        task_id="start",
        outlets=[gv.DS_START]
    )


start_dag = start_pipeline()