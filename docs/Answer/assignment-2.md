#Assignment-2 Answer

**Q1**

> **查询上映时间 >= 2014年并且评分<=7.0的电影，**
>
> **输出:电影标题，导演姓名，评分(`rating`)**



```sql
use movies;
select m.title, p.name, m.rating from movie m, person p
	where m.year >= 2014 and m.rating <= 7.0 and m.director=p.id
```

**count=348**

---





**Q2**

> **查询这样的导演姓名（在`movie`.`director`中有记录的即导演），这些导演没有在任何一部电影中担任演员。**
>
> **输出：导演姓名**

```sql
use movies;   
select p.`name` from `person` as p
	where
		p.`id` in
			(select `director` from `movie`)
		and
		p.`id` not in
			(select `actor_id` from `movie_actor`);
```

**count=608**

---



**Q3**

> **查询 `Edward Norton` 或者 `Aamir Khan` 参演过的所有电影**
>
> **输出: 电影标题,该电影的上映时间**

```sql
use movies;
select m.title , m.year from  movie m, movie_actor ma, person p
    where m.id=ma.movie_id and  (p.name='Edward Norton' or p.name='Aamir Khan') and p.id=ma.actor_id;
```

**count=9**

---



**Q4**

> **查询类型为 `Action`且 评分>8.0 的电影，并且该电影的导演执导的所有电影>=2部**
>
> **输出:电影标题,导演姓名,评分**

```sql
use movies;
select m.title, m.rating, p.name from movie_genre mg, movie m, genre g, person p
	where m.id=mg.movie_id and g.id = mg.genre_id and g.name='Action' and m.rating>8.0 and p.id = m.director and m.director in
		(select director from  movie group by director having count(*) >= 2) 
```

**count=11**

ps: 想不清楚的时候，先全部连接获得所有需要的字段 `where m.id=mg.movie_id and g.id = mg.genre_id and g.name='Action' and p.id = m.director` ， 然后考虑用聚合来获得` >= 2` 的问题。

---



**Q5**

> **查询电影，该电影至少包含`Horror`，`Thriller`这2种类型**
>
> **输出：电影名称，导演名称**

```sql
select m.`title`, p.`name`
	from `movie` as m, `person` as p
	where m.`director` = p.`id` and exists
    (
		select * from
			`movie_genre` as X1, `genre` as X2,
			`movie_genre` as Y1, `genre` as Y2
		where
			X1.`genre_id` = X2.`id`
			and X2.`name` = 'Horror'
			and Y1.`genre_id` = Y2.`id`
			and Y2.`name` = 'Thriller'
			and X1.`movie_id` = Y1.`movie_id`
			and X1.`movie_id` = m.`id`
	);
```

**count=44**

答案的思路是对整个电影条目进行 `exist` 判断，对于一个电影是否存在两个类型符合题目条件。

也可以用两个`in`，`m.id` 在 `movie_genre` 中有对应`Horror` 也有对应的`Thriller`

---



**Q6**

> **查询电影，该电影仅仅包含`Horror`，`Thriller`这2种类型**
>
> **输出：电影名称，导演名称**

```sql
select m.`title`, p.`name`
	from `movie` as m, `person` as p
	where m.`director` = p.`id` and exists
    (
		select * from
			`movie_genre` as X1, `genre` as X2,
			`movie_genre` as Y1, `genre` as Y2
		where
			X1.`genre_id` = X2.`id`
			and X2.`name` = 'Horror'
			and Y1.`genre_id` = Y2.`id`
			and Y2.`name` = 'Thriller'
			and X1.`movie_id` = Y1.`movie_id`
			and X1.`movie_id` = m.`id`
	) and not exists
    (
		select * from
			`movie_genre` as X1, `genre` as X2,
			`movie_genre` as Y1, `genre` as Y2
		where
			X1.`genre_id` = X2.`id`
			and X2.`name` != 'Horror'
            and X2.`name` != 'Thriller'
			and Y1.`genre_id` = Y2.`id`
			and Y2.`name` != 'Horror'
            and Y2.`name` != 'Thriller'
			and X1.`movie_id` = Y1.`movie_id`
			and X1.`movie_id` = m.`id`
    );
```

**count=16**

有 `Horror` 或者`Thriller`, 但不同时有两个

（看着长，但是也就是写得长了点，思路不难）

---



**Q7**

> **查询在2014年之前（包括2014），有超过3部电影上映的演员以及他参演的电影名**
>
> **输出: 演员名，参演的电影名，**

---



**Q8**

> **查询演员，该演员参演了`Joss Whedon`导演执导的所有电影。**
>
> **输出：演员姓名**

---



**Q9**

> **查询这样的演员与导演，这个演员参演了该导演执导的所有电影，且该导演导演了至少2部电影。**
>
> **输出： 演员姓名，导演姓名**

---



**Q10***

!!! Warning "Additional Question"

> **查询每一种类型电影对应的影帝/影后（对于每一种类型，该影帝/影后至少有三部电影是这个类型，并且在所有至少参演了3部该类型电影的演员中，获得的平均评分最高）**
>
> **输出： 类型，演员名，平均评分**