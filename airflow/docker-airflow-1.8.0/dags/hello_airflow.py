from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'someone',
    'start_date': datetime(2019, 2, 1, 10, 0, 0),
    'schedule_interval': '*/30 * * * *',
    'catchup': False
}

dag = DAG('test_dag', default_args=default_args)

t1 = BashOperator(
    task_id='t1',
    bash_command='echo t1',
    dag=dag)

t2 = BashOperator(
    task_id='t2',
    bash_command="echo '{{ dag_run.get_task_instance('t1').end_date.strftime('%Y%m%d%H%M') }}'",
    dag=dag)

t2.set_upstream(t1)
