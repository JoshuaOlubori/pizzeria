# DAG and task decorators for interfacing with the TaskFlow API
from airflow.decorators import dag, task, task_group
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from pendulum import datetime
from include import global_variables as gv

@dag(
    start_date=datetime(2023, 1, 1),
    # after being unpaused this DAG will run once, afterwards it can be run
    # manually with the play button in the Airflow UI
    schedule=[gv.DS_START],
    catchup=False,
    description="Run this DAG to start the pipeline!",
    tags=["setup"],
)
def database_init():

    # this task uses the BashOperator to run a bash command creating an Airflow
    # pool called 'duckdb' which contains one worker slot. All tasks running
    # queries against DuckDB will be assigned to this pool, preventing parallel
    # requests to DuckDB.

    execute_query = SQLExecuteQueryOperator(
    task_id="execute_query",
    conn_id = "postgres_conn",
    sql="init.sql",
    show_return_value_in_logs = True
)



database_init = database_init()