from airflow.hooks import postgres_hook
from airflow.operators import python_operator
from airflow import DAG
from datetime import timedelta
#from MySQLdb import _mysql
#db=_mysql.connect()
# for script call
from airflow.operators.bash import BashOperator
# for database call
#from airflow.operators import mysql_operator
from airflow.providers.postgres.operators import  postgres_operator
from airflow.providers.mysql.operators  import mysql_operator
import datetime
import pendulum
with DAG(
        dag_id='ltv_vehicle_listing',
        schedule_interval='@daily',
        # start_date=datetime(year=2022, month=7, day=17),
        start_date=pendulum.datetime(2021, 7, 17, tz="UTC"),
        catchup=False,
) as dag:
    # 1)preprocessing
    """ 
    call the shell script to check number of lines in the file before load and column count and check header in the below task
     pass the script name in the command
    # create_command="./Users/navyasatish/airflow-docker/dags/ltv_vehicle_listing/file_header_record_count_check.sh"
"""
    file_check_before_load = BashOperator(
        task_id="file_check_before_load",
        bash_command="/Users/navyasatish/airflow-docker/dags/ltv_vehicle_listing/file_header_record_count_check.sh",
        dag=dag,
    )

    # 1.1 create first raw table
    create_raw_table = PostgresOperator(
        task_id="create_raw_table",
        sql="/Users/navyasatish/airflow-docker/dags/ltv_vehicle_listing/create_raw_table.sql",
        mysql_conn_id="postgres",
        dag=dag,
    )

    # 1.2 Load data from file to raw table
    load_raw_data_to_table = mysql_operator(
        task_id="load_raw_data_to_table",
        sql="/Users/navyasatish/airflow-docker/dags/ltv_vehicle_listing/load_raw_data_to_table.sql",
        mysql_conn_id='',
        dag=dag,
    )

    # 2)generate statistics
    generate_statistics = mysql_operator

    # 3) highest_mileage_vehicles
    highest_mileage_vehicles = mysql_operator

    # 4) Load data into the prod table.
    vehicle_decision_maker = mysql_operator

    # 5) vin map
    vin_map = mysql_operator

# setting the dependencies.
# file_check_before_load>>create_raw_table>>generate_statistics>>vehicle_decision_maker>>vin_map

create_raw_table.set_upstream(file_check_before_load)
generate_statistics.set_upstream(create_raw_table)
vehicle_decision_maker.set_upstream(create_raw_table)
vin_map.set_upstream(create_raw_table)
