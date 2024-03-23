# from airflow import DAG
# from airflow.utils.dates import days_ago
# from airflow.providers.postgres.operators.postgres import PostgresHook
# from airflow.operators.python import PythonOperator

# # Default arguments for the DAG
# default_args = {
#     'owner': 'airflow',
#     'start_date': days_ago(1),  # Start one day ago
#     'depends_on_past': False,  # Don't wait for previous runs
# }

# # Define the DAG
# with DAG(
#     dag_id='download_postgres_tables_to_csv',
#     default_args=default_args,
#     schedule_interval=None,  # Run manually
# ) as dag:

#     # Function to download a table to CSV
#     def download_table_to_csv(table_name, csv_filepath):
#         postgres_hook = PostgresHook(postgres_conn_id='your_postgres_connection')
#         with postgres_hook.get_conn() as conn:
#             with conn.cursor() as cur:
#                 cur.execute(f"SELECT * FROM {table_name}")
#                 data = cur.fetchall()
                
#                 # Write data to CSV
#                 with open(csv_filepath, 'w') as csvfile:
#                     # Write header row (optional)
#                     # csvfile.writerow([column.name for column in cur.description])
#                     csvfile.writerows(data)

#     # Get list of tables in Postgres
#     def get_postgres_tables():
#         postgres_hook = PostgresHook(postgres_conn_id='your_postgres_connection')
#         with postgres_hook.get_conn() as conn:
#             with conn.cursor() as cur:
#                 cur.execute("""
#                     SELECT table_name
#                     FROM information_schema.tables
#                     WHERE table_schema = 'public';
#                 """)
#                 tables = [row[0] for row in cur.fetchall()]
#         return tables

#     # Get list of tables
#     get_tables_task = PythonOperator(
#         task_id='get_tables',
#         python_callable=get_postgres_tables,
#         provide_context=True,  # Pass returned value to next task
#     )

#     # Loop through tables and download each one
#     for table in get_tables_task.provide_context:
#         download_task = PythonOperator(
#             task_id=f'download_{table}',
#             python_callable=download_table_to_csv,
#             op_args=[table, f'/path/to/local/storage/{table}.csv'],  # Define output CSV path
#             provide_context=True,
#         )
#         get_tables_task >> download_task
