# insert test user
insert into users (user_name, password, created_at, modified_at) values('test_user', 'pass', cast(now() as datetime), cast(now() as datetime));

# insert test answer
insert into answers (answer, created_at, modified_at) values('test_answer1', cast(now() as datetime), cast(now() as datetime));
insert into answers (answer, created_at, modified_at) values('test_answer2', cast(now() as datetime), cast(now() as datetime));
insert into answers (answer, created_at, modified_at) values('test_answer3', cast(now() as datetime), cast(now() as datetime));
insert into answers (answer, created_at, modified_at) values('test_answer4', cast(now() as datetime), cast(now() as datetime));

# insert test category
insert into categories (parent_id, name, created_at, modified_at) values(null, 'test_root_category', cast(now() as datetime), cast(now() as datetime));

# insert questions
insert into questions (category_id, answer_id, question, description, created_at, modified_at) values(1, 1, 'test_question', 'test_description', cast(now() as datetime), cast(now() as datetime));

# insert dummy answers
insert into dummy_answers (question_id, answer_id, created_at, modified_at) values (1, 2, cast(now() as datetime), cast(now() as datetime));
insert into dummy_answers (question_id, answer_id, created_at, modified_at) values (1, 3, cast(now() as datetime), cast(now() as datetime));
insert into dummy_answers (question_id, answer_id, created_at, modified_at) values (1, 4, cast(now() as datetime), cast(now() as datetime));

