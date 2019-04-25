import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2019, 4, 1)
}

dag = DAG(
    dag_id='01-1_catchup_True',
    default_args=default_args,
    description='test for catchup True',
    schedule_interval=timedelta(days=1),
    catchup=True
)

t1 = BashOperator(
    task_id='echo_something',
    bash_command='echo "do task"',    
    dag=dag,
)

t1

