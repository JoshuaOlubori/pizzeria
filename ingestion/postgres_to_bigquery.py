import os
import psycopg2
from google.cloud import bigquery
from google.oauth2 import service_account

# PostgreSQL connection details
PG_HOST = "your_postgres_host"
PG_PORT = 5432
PG_DATABASE = "your_database_name"
PG_USER = "your_username"
PG_PASSWORD = "your_password"

# BigQuery configuration
BQ_PROJECT_ID = "your_gcp_project_id"
BQ_DATASET_ID = "your_bigquery_dataset_id"

# Mapping dictionary for PostgreSQL to BigQuery data types
PG_TO_BQ_TYPES = {
    'bigint': 'INTEGER',
    'int8': 'INTEGER',
    'int4': 'INTEGER',
    'int2': 'INTEGER',
    'numeric': 'FLOAT',
    'double precision': 'FLOAT',
    'real': 'FLOAT',
    'varchar': 'STRING',
    'text': 'STRING',
    'char': 'STRING',
    'date': 'DATE',
    'timestamp': 'TIMESTAMP',
    'bool': 'BOOLEAN'
}

# Authenticate with Google Cloud
credentials = service_account.Credentials.from_service_account_file('path/to/service_account_key.json')
bigquery_client = bigquery.Client(project=BQ_PROJECT_ID, credentials=credentials)

# Connect to PostgreSQL
conn = psycopg2.connect(
    host=PG_HOST,
    port=PG_PORT,
    database=PG_DATABASE,
    user=PG_USER,
    password=PG_PASSWORD
)
cursor = conn.cursor()

# Get a list of all table names
cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
table_names = [row[0] for row in cursor.fetchall()]

# Upload each table to BigQuery
for table_name in table_names:
    cursor.execute(f"SELECT * FROM {table_name} LIMIT 0")
    columns = [desc[0] for desc in cursor.description]
    column_types = [PG_TO_BQ_TYPES.get(desc[1].lower(), 'STRING') for desc in cursor.description]

    # Create a BigQuery table if it doesn't exist
    table_ref = bigquery_client.dataset(BQ_DATASET_ID).table(table_name)
    table = bigquery.Table(table_ref)
    table = table_ref.to_gapi()
    table.schema = [bigquery.SchemaField(col, data_type) for col, data_type in zip(columns, column_types)]
    table_resource = bigquery_client.create_table(table, exists_ok=True)

    # Load data into the BigQuery table
    cursor.execute(f"SELECT * FROM {table_name}")
    data = cursor.fetchall()
    errors = bigquery_client.insert_rows_from_matrix(table_resource.full_table_id, data, row_ids=None)
    if not errors:
        print(f"Table {table_name} uploaded successfully.")
    else:
        print(f"Errors occurred while uploading table {table_name}: {errors}")

# Close the PostgreSQL connection
cursor.close()
conn.close()