from peewee import *
import time

# init the ORM

db = PostgresqlDatabase('DATABASE RK_3', user='postgres', password='secret',
                           host='10.1.0.9', port=5432)

class Teacher(Model):
    t_id = PrimaryKeyField(null=False)
    t_fio = CharField()
    t_fac = CharField()
    max_students = IntegerField()
    class Meta:
        db_table = 'teacher'
        database = db

class Students(Model):
    s_id = PrimaryKeyField(null=False)
    s_fio = CharField()
    birthday = DateField()
    s_fac = CharField()
    s_teacher_id = IntegerField()
    class Meta:
        db_table = 'students'
        database = db



# first request
# find a department where most students have not decided on a supervisor

query_Teacher = Teacher.select()
query_Students = Students.select()
departaments = {}

for student in query_Students:
    departaments["student.s_fac"] = 0

for student in query_Students:
    if student.s_teacher_id != "null":
        count = departaments.get("student.s_fac", 0)
        count += 1
        departaments["student.s_fac"] = count

min_val = min(departaments.values())
final_dict = {k:v for k, v in departaments.items() if v == min_val}
print(final_dict) # the answer

# second request
# find students of 1990 year of born and who is a student of Rudakov

query_Teacher = Teacher.select()
query_Students = Students.select()
needed_ID = 0

for teacher in query_Teacher:
    if teacher.t_fio == "Рудаков Игорь Владимирович":
        needed_ID = teacher.t_id

final_students = []

for student in query_Students:
    bday = datetime.date(student.birthday)
    if student.s_teacher_id == needed_ID and bday.year == 1990:
        final_students.append(student)

print(final_students) # the answer



# third request

query_Teacher = Teacher.select()
query_Students = Students.select()

teachers = []

for teacher in query_Teacher:
    if teacher.t_caf == "Л":
        teachers.append(teacher)

fio = {}
final_mass = []

for teacher in teachers:
    fio["teacher.t_fio"] = 0

for student in query_Students:
    for teacher in teachers:
        if student.s_teacher_id == teacher.t_id:
            count = fio.get("teacher.t_fio", 0)
            count += 1
            fio["teacher.t_fio"] = count
        if fio["teacher.t_fio"] == teacher.max_students:
            final_mass.append(teacher.t_fio)

print(final_mass) # the answer