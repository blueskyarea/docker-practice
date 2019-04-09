import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': True,
    'start_date': datetime(2019, 4, 1)
}

dag = DAG(
    '001_depends_on_past',
    default_args=default_args,
    description='test for depends_on_past',
    schedule_interval=timedelta(days=1),
)

t1 = BashOperator(
    task_id='sleep',
    depends_on_past=False,
    bash_command='sleep 5',
    dag=dag,
)

