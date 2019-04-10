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
    dag_id='001_depends_on_past_True',
    default_args=default_args,
    description='test for depends_on_past',
    schedule_interval=timedelta(days=1),
)

t1 = BashOperator(
    task_id='echo_something',
    depends_on_past=False,
    bash_command='echo "do task"',    
    dag=dag,
)

t1

