# Assignment 3

## Overview

The third homework is similar to the second.To reduce your workload, we have constructed data for two of the problems**(3.7 & 3.13)** in the paper-based homework, which was assigned on Tuesday.

You need to run these sql statements in a live environment and return the correct results. **{++Also, the homework submitted next Tuesday does not need to cover these two questions.++}**

This task is an opportunity to:

* Learn basic and certain advanced SQL features
* Get familiar with using and applying sql in specific application scenarios

**Release Date:** March 19, 2021 / 15:25

**Due Date:** March 19, 2021 / 17:10



----

## Preliminary

#### Download and Load

You need to download the **DataSet** we have prepared for you in the `elearning`.

- `school.sql`
- `employment.sql`

The steps for downloading and importing are the same as for [Assignment-2](assignment2.md)





## Table Structure

!!! hint 
    **Before writing SQL statements, please carefully observe the column name and structure of each table. A clearer understanding of the overall architecture will help you quickly and accurately finish this work.**

### `school.sql`

* **t** => teacher

  | Column | Type    | Example |
  | ------ | ------- | ------- |
  | Id     | Varchar | T15     |
  | tname  | Varchar | DI      |

* **s** => student

  | Column | Type    | Example |
  | ------ | ------- | ------- |
  | Id     | Varchar | S100    |
  | Sname  | Varchar | YUE     |
  | age    | Int     | 19      |
  | Sex    | Char(1) | M       |

* **c** => course--teacher  

  > As the course name is not used in the query, we have not made up

  | Column | Type    | Example |
  | ------ | ------- | ------- |
  | id     | Varchar | C1      |
  | tid    | Varchar | t10     |

* **sc** => studnet--course

  | Column | Type    | Example |
  | ------ | ------- | ------- |
  | sid    | Varchar | S100    |
  | cid    | Varchar | C10     |
  | Score  | Double  | 88.88   |

-----



### `employment.sql`

* **comp** => company

  | Column | Type    | Example |
  | ------ | ------- | ------- |
  | Id     | Varchar | C10     |
  | Cname  | Varchar | Amazon  |

* **emp**

  | Column | Type    | Example |
  | ------ | ------- | ------- |
  | Id     | Varchar | S10     |
  | Ename  | Varchar | Amy     |
  | Age    | Int     | 60      |
  | Sex    | Char    | F       |

* **works**

  | Column | Type    | Example |
  | ------ | ------- | ------- |
  | cId    | Varchar | C10     |
  | sid    | Varchar | E10     |
  | Salary | Double  | 886     |



----

## Tasks

### 3.7 -> school.sql

**Q1**

> **统计有学生选修的课程门数**
>
> **输出: count**

----

**Q2**

> **选修C4课程的女学生的平均年龄**
>
> **输出: avg_age**

----

**Q3**

> **`LIU`老师所授课程的每门课程的平均成绩**
>
> **课程ID，平均成绩**

---

**Q4**

> **每门课程的学生选修人数，并且只统计选课人数>10的课程**
>
> **输出: 课程ID，人数**
>
> **排序：人数降序，相同则按课程号升序**

----

**Q5**

> **学号比`WANG`同学大，年龄比他小的学生姓名**
>
> **输出: 学生姓名**

---

**Q6**

> **表SC中，查找成绩为空的学生**
>
> **输出: 学号，学生姓名**

----

**Q7**

> **姓名以 `L` 打头的所有学生**
>
> **输出: 姓名，年龄**

---

**Q8**

> **年龄大于女同学平均年龄的男生**
>
> **输出: 姓名， 年龄**

---

**Q9**

> **年龄大于所有女同学年龄的男生**
>
> **输出: 姓名， 年龄**

----



### 3.13 -> employment.sql

**Q1**

> **用create table 创建三个表的副本，命名为`xx_copy`, `xx`为原表名**
>
> **需要指出主键和外键**
>
> **并且导入原表所有数据**

---

**Q2**

> **年龄>50的男职工的工号和姓名**
>
> **输出: 工号， 姓名**

---

**Q3**

（修改过）

> **查找在一个任意一个公司工资超过1000元的职工**
>
> **输出: 工号， 姓名**
>
> **去重**

----

**Q4**

> **至少在`C4`和`C8` 公司兼职的职工**
>
> **输出: 工号， 姓名**

----

**Q5**

> **在`Facebook` 工作，工资超过1000元的男性职工**
>
> **输出: 工号，姓名**

-----

**Q6**

> **每个职工兼职的公司数目和工资总数**
>
> **输出: 工号，NUM, SUM_SALARY**

----

**Q7**

> **查找职工，该职工在`S6`所在的全部公司都有兼职**
>
> **输出: 工号**

---

**Q8**

> **在`Tencent` 中搜索低于本公司平均工资的员工**
>
> **输出: 工号，姓名**

----

**Q9**

> **在Q1创建的副本中，为每一个公司的50岁以上的员工加薪100元**
>
> **若职工为多个公司工作，可重复加**

---

**Q10**

> **在Q1创建的副本中，删除`emp_copy`和`works_copy` 中年龄>60的有关元组**

