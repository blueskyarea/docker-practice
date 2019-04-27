from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2019, 4, 1, 10, 0, 0),
}

dag = DAG(
    dag_id='02_dependency_task',
    default_args=default_args,
    schedule_interval='00 02 * * *',
    description='test for dependency',
    catchup=False
)

t1 = BashOperator(
    task_id='t1',
    bash_command='echo t1',
    dag=dag)

t2 = BashOperator(
    task_id='t2',
    bash_command='echo t2',
    dag=dag)

t3 = BashOperator(
    task_id='t3',
    bash_command='echo t3',
    dag=dag)

t4 = BashOperator(
    task_id='t4',
    bash_command='echo t4', 
    dag=dag
)

# dependency between tasks
t2.set_upstream(t1)
t3.set_upstream(t1)
t4.set_upstream([t2, t3])
