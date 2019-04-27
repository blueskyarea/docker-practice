From web console(http://localhost:8080)

#### Test1 catchup behavior
1. Enable 01-1_catchup_True
2. Enable 01-2_catchup_False
3. Refresh page(web console) until stop the updating
4. Compare the difference of result

Note:
To set False as default, catchup_by_default=False on airflow.cfg

#### Test2 dependency task
1. Enable 02_dependency_task
2. Check log
```
docker exec -it my-airflow bash -c "cat /usr/local/airflow/logs/02_dependency_task/t1/*"
docker exec -it my-airflow bash -c "cat /usr/local/airflow/logs/02_dependency_task/t2/*"
docker exec -it my-airflow bash -c "cat /usr/local/airflow/logs/02_dependency_task/t3/*"
docker exec -it my-airflow bash -c "cat /usr/local/airflow/logs/02_dependency_task/t4/*"
```

Note:
docker exec -it my-airflow cat /usr/local/airflow/logs/02_dependency_task/t1/* returns
"No such file or directory"

#### Test3 retry on task

#### Test4 retry on dag
