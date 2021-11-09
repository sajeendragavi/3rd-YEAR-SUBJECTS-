CREATE DATABASE RK_3;

CREATE TABLE teacher(
    t_id BIGSERIAL NOT NULL ,
    t_fio text NOT NULL ,
    t_fac text NOT NULL ,
    max_students integer NOT NULL
);

CREATE TABLE students(
    s_id BIGSERIAL NOT NULL ,
    s_fio text NOT NULL ,
    birthday date NOT NULL ,
    s_fac text NOT NULL ,
    s_teacher_id integer
);

ALTER TABLE teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (t_id);

ALTER TABLE students
    ADD CONSTRAINT stud_pkey PRIMARY KEY (s_id);

ALTER TABLE students
    ADD CONSTRAINT stud_fkey FOREIGN KEY (s_teacher_id) REFERENCES teacher(t_id);

INSERT INTO teacher (t_fio, t_fac, max_students) VALUES ('Рудаков Игорь Владимирович', 'ИУ7', 6);
INSERT INTO teacher (t_fio, t_fac, max_students) VALUES ('Строганов Юрий Владимирович', 'ИУ7', 5);
INSERT INTO teacher (t_fio, t_fac, max_students) VALUES ('Куров Андрей Владимирович', 'ИУ7', 6);
INSERT INTO teacher (t_fio, t_fac, max_students) VALUES ('Скорикова Татьяна Петровна', 'Л', 1);

SELECT * from teacher;

INSERT INTO students (s_fio, birthday, s_fac, s_teacher_id) VALUES ('Иванов Иван Иванович', date('25-09-1990'), 'ИУ', 1);
INSERT INTO students (s_fio, birthday, s_fac, s_teacher_id) VALUES ('Петров Петр Петрович', date('12-11-1987'), 'Л', Null);
SELECT * from students;

DROP FUNCTION func();

CREATE OR REPLACE FUNCTION func()
returns table(student_id bigint, teacher_id integer)
AS
$$
declare
    cnt_for_teacher integer[];
    t_id integer;
    cnt integer;
    r record;
    r2 record;
    i integer;
    cnt_all integer := 0; 
        i = i + 1;
    end loop;



    for r in select * from students
    loop
        if r.s_teacher_id is null
        then
            i = 0;
            while i < cnt_all
            loop
                if cnt_for_teacher[i] != 0
                then
                    cnt_for_teacher[i] = cnt_for_teacher[i] - 1;
                    return query select r.s_id, i+1;
                    i = cnt_all;
                end if;
                i = i + 1;
            end loop;
        end if;
    end loop;

end
    $$ LANGUAGE plpgsql;

select * from func();

# 1_1
# find a department where most students have not decided on a supervisor
select top(1) s_fac
from
(select s_fac, count(*) cnt
from students
where s_teacher_id is null
group by s_fac) as tmp
order by cnt desc;


# 2_1
# second request
# find students of 1990 year of born and who is a student of Rudakov


select s_fio, s_id
from teacher t join students s on t.t_id = s.s_teacher_id
where year(birthday) = 1990 and t_fio = 'Рудаков Игорь Владимирович';

# 3_1
# third request

select t_fio
from teacher t join
(select s_teacher_id, count(*) as cnt
from teacher t join students s on t.t_id = s.s_teacher_id
group by s_teacher_id
having t_fac = 'Л') as tmp on t.t_id = tmp.s_teacher_id
where max_students = cnt;
