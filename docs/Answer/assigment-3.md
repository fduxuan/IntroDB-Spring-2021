#Assignment-3 Answer

## 3.7

**Q1**

> **统计有学生选修的课程门数**
>
> **输出: count**

```sql
use school;
select count(distinct cid) from sc;
```

**count=201**

---

**Q2**

> **选修C4课程的女学生的平均年龄**
>
> **输出: avg_age**

```sql
use school;
select avg(s.age) from sc, s where sc.sid=s.id and s.sex='F' and sc.cid='C4'
```

**avg=19.8780**



---

**Q3**

> **`LIU`老师所授课程的每门课程的平均成绩**
>
> **课程ID，平均成绩**

```sql
use school;
select sc.cid, avg(sc.score)  from sc, t, c 
    where sc.cid = c.id and c.tid=t.id and t.tname='LIU'
    group by sc.cid;
```

**C200 , 80.994595**

**C201 , 79.469474**



---

**Q4**

> **每门课程的学生选修人数，并且只统计选课人数>10的课程**
>
> **输出: 课程ID，人数**
>
> **排序：人数降序，相同则按课程号升序**

```sql
use school;
select sc.cid, count(*) as num from sc 
    group by sc.cid having num > 10
    order by num desc, sc.cid ASC;
```

**C19, 96**



----

**Q5**

> **学号比`WANG`同学大，年龄比他小的学生姓名**
>
> **输出: 学生姓名**

```sql
use school;
select x.sname from s as x, s as y
    where y.sname='WANG' and x.id > y.id and x.age < y.age;
```

**count=4： CHA ZENG YOU JI**

---

**Q6**

> **表SC中，查找成绩为空的学生**
>
> **输出: 学号，学生姓名**

```sql
use school;
select s.id, sname from s, sc where score is null;
```

**count=0**

---

**Q7**

> **姓名以 `L` 打头的所有学生**
>
> **输出: 姓名，年龄**

```sql
use school;
select sname, age from s where sname like 'L%';
```

**count=10**

----

**Q8**

> **年龄大于女同学平均年龄的男生**
>
> **输出: 姓名， 年龄**

```sql
use school;
select x.sname, x.age from s as x
    where x.sex='M' and x.age > 
    (select avg(y.age) from s as y
         where y.sex='F');
```

**count=53**

---

**Q9**

> **年龄大于所有女同学年龄的男生**
>
> **输出: 姓名， 年龄**

```sql
use school;
select x.sname, x.age from s as x
    where x.sex='M' and x.age>
    all(select y.age from s as y where y.sex='F');
```

**count=0**



---



## 3.13

**Q1**

> **用create table 创建三个表的副本，命名为`xx_copy`, `xx`为原表名**
>
> **需要指出主键和外键**
>
> **并且导入原表所有数据**

```sql
use employment;
CREATE TABLE `comp_copy` (
  `id` varchar(10) NOT NULL,
  `cname` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `emp_copy` (
  `id` varchar(10) NOT NULL,
  `ename` varchar(20) NOT NULL,
  `age` int DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `works_copy` (
  `eid` varchar(10) NOT NULL,
  `cid` varchar(10) NOT NULL,
  `salary` int DEFAULT NULL,
  PRIMARY KEY (`eid`,`cid`),
  KEY `works_copy` (`cid`),
  CONSTRAINT `works_ibfk_1_1` FOREIGN KEY (`eid`) REFERENCES `emp_copy` (`id`),
  CONSTRAINT `works_ibfk_2_2` FOREIGN KEY (`cid`) REFERENCES `comp_copy` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT  INTO  emp_copy  SELECT   *  FROM  emp ;
INSERT  INTO  comp_copy  SELECT   *  FROM  comp ;
INSERT  INTO  works_copy  SELECT   *  FROM  works ;
```



---

**Q2**

> **年龄>50的男职工的工号和姓名**
>
> **输出: 工号， 姓名**

```sql
use employment;
select id, ename from emp where age > 50 and sex='M';
```

**count=8**

---

**Q3**

（修改过）

> **查找在一个任意一个公司工资超过1000元的职工**
>
> **输出: 工号， 姓名**
>
> **去重**

```sql
use employment;
select distinct emp.id, ename from works, emp
    where salary > 1000 and eid=emp.id;
```

**count=240**



----

**Q4**

> **至少在`C4`和`C8` 公司兼职的职工**
>
> **输出: 工号， 姓名**

```sql
use employment;
select emp.id, emp.ename from emp, works w1, works w2 
    where w1.cid='C4' and w2.cid='C8' and w1.eid=w2.eid and w1.eid = emp.id;
```

**count=59**



---

**Q5**

> **在`Facebook` 工作，工资超过1000元的男性职工**
>
> **输出: 工号，姓名**

```sql
use employment;
select emp.id, emp.ename from comp, emp, works
    where emp.id=works.eid and emp.sex='M' and comp.id=works.cid and comp.cname='Facebook' and works.salary>1000;
```

**count=36**

---

**Q6**

> **每个职工兼职的公司数目和工资总数**
>
> **输出: 工号，NUM, SUM_SALARY**

```sql
use employment;
select eid, count(cid), sum(salary) from works group by eid;
```

**s1, 5, 5077**



---

**Q7**

> **查找职工，该职工在`S6`所在的全部公司都有兼职**
>
> **输出: 工号**

```sql
use employment;
select distinct w1.eid from works w1 
    where not exists ( /*不存在这样的公司*/
        select * from works w2
            where w2.eid='S6' and w2.cid not in ( /* S6在该公司，但是w1.eid不在*/
                select w3.cid from works w3 where w3.eid = w1.eid
            )
    )

```

**count=5**



---

**Q8**

> **在`Tencent` 中搜索低于本公司平均工资的员工**
>
> **输出: 工号，姓名, 工资**

```sql
select emp.id, ename, salary from emp, works, comp
    where comp.cname='Tencent' and comp.id=works.cid and emp.id=works.eid
    and salary < (
        select avg(salary) from works as w, comp as c
            where c.cname='Tencent' and c.id=w.cid 
    )
```

**count=59**



---

**Q9**

> **在Q1创建的副本中，为每一个公司的50岁以上的员工加薪100元**
>
> **若职工为多个公司工作，可重复加**

```sql
use employment;
update works_copy set salary=salary+100 
where eid in (select id from emp where age > 50)

```

---

**Q10**

> **在Q1创建的副本中，删除`emp_copy`和`works_copy` 中年龄>60的有关元组 **

```sql
use employment;
delete from works_copy where eid in (select id from emp where age > 60);
delete from emp_copy where age > 60
```

