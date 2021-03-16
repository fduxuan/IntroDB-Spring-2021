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

```sql
use movies;
select m.title, p.name from movie m, person p, movie_actor ma1 
	where m.id=ma1.movie_id and p.id=ma1.actor_id and m.year <= 2014 and ma1.actor_id in
		(select mg.actor_id from movie_actor mg, movie mm 
			where mm.id = mg.movie_id and mm.year<=2014
            group by actor_id having count(*)>3);
```

**count=848**

注意点：这道题很有可能会在聚合的地方不增加2014年限制，从而导致答案超过1000

---



**Q8**

> **查询演员，该演员参演了`Joss Whedon`导演执导的所有电影。**
>
> **输出：演员姓名**

```sql
select p.`name` from `person` as p
	where
		p.`id` in
			(select `actor_id` from `movie_actor`)
		and not exists
        (
			select *
				from
					`person` as pp,
                    `movie` as mm
				where
					pp.`name` = 'Joss Whedon'
					and mm.`director` = pp.`id`
                    and not exists
                    (
						select *
                        from
							`movie_actor` as ma
						where
							mm.`id` = ma.`movie_id`
							and
                            ma.`actor_id` = p.`id`
                    )
        );
```

**count=2**

---



**Q9**

> **查询这样的演员与导演，这个演员参演了该导演执导的所有电影，且该导演导演了至少2部电影。**
>
> **输出： 演员姓名，导演姓名**

```sql
select p.`name`, d.`name`
	from `person` as p, `person` as d
	where
		p.`id` in
			(select `actor_id` from `movie_actor`)
		and
        d.`id` in
		(
			select X.`director`
			from `movie` as X, `movie` as Y
			where
				X.`director` = Y.`director`
				and X.`id` != Y.`id`
		)
		and not exists
        (
			select *
				from
                    `movie` as m
				where
					m.`director` = d.`id`
                    and not exists
                    (
						select *
                        from
							`movie_actor` as ma
						where
							m.`id` = ma.`movie_id`
							and
                            ma.`actor_id` = p.`id`
                    )
        );
```

**count=50**

---



**Q10***

!!! Warning "Additional Question"

> **查询每一种类型电影对应的影帝/影后（对于每一种类型，该影帝/影后至少有三部电影是这个类型，并且在所有至少参演了3部该类型电影的演员中，获得的平均评分最高）**
>
> **输出： 类型，演员名，平均评分**

这道题最简单的思路是： 

* 先把所有的表连接起来（因为所需的字段分散在不同的表中）
* 对 （演员，类型）这两个字段做**聚合分组**，并按照这个分组求出 每个演员在每个类型上的所有电影的平均分，并在聚合中增加`count` 筛选出该类型对于该演员电影数必须>=3
* 然后对类型分组，求出最大的平均分

> Ps: 当涉及到嵌套子句比较长的时候，可以用 `with` 来优化(定义子句别名)

```sql
with whole as (
	select g.name as genre, p.name as actor, avg(m.rating) as avg_rating
	from genre g, movie m, movie_actor ma, movie_genre mg, person p
	where g.id = mg.genre_id and m.id=mg.movie_id and p.id=ma.actor_id and m.id=ma.movie_id 
  group by genre, actor having count(rating) >= 3
)
```

这个 `whole`内部子句实现的就是步骤的前两步，得到了（演员，类型）对应的平均得分

<img src="../10.png" style="zoom:50%;" />

```sql
use movies;	
with whole as (
	select g.name as genre, p.name as actor, avg(m.rating) as avg_rating
	from genre g, movie m, movie_actor ma, movie_genre mg, person p
	where g.id = mg.genre_id and m.id=mg.movie_id and p.id=ma.actor_id and m.id=ma.movie_id 
  group by genre, actor having count(rating) >= 3
)
select w.genre as genre, max(w.avg_rating) as max_rating from whole w group by genre
```

到了这一步就求出了上一步中，每个类型对应的最大平均分

<img src="../10-2.png" style="zoom:50%;" />



最后求出最大的条目

```sql
use movies;	
with whole as (
	select g.name as genre, p.name as actor, avg(m.rating) as avg_rating
	from genre g, movie m, movie_actor ma, movie_genre mg, person p
	where g.id = mg.genre_id and m.id=mg.movie_id and p.id=ma.actor_id and m.id=ma.movie_id 
  group by genre, actor having count(rating) >= 3
), 
max_genre as (
  select w.genre as genre, max(w.avg_rating) as max_rating from whole w group by genre
)
select ww.actor as actor, ww.genre as genre, ww.avg_rating as rating from whole ww, max_genre as mg 
	where ww.genre = mg.genre and ww.avg_rating >= mg.max_rating;
```

<img src="../10-3.png" style="zoom:50%;" />

注意，一个类型的影帝/影后可能不止一个（平均分相同）

**count=17**



-----
!!! hint "lujiayi同学的另一种写法更简洁和易于理解"
```sql
select g.name as genre,p.name,avg(mm.rating) as average_rating
from movie_actor ma,movie mm,movie_genre mg,person p,genre g
where mg.movie_id=mm.id and ma.movie_id=mm.id and g.id=mg.genre_id and p.id=ma.actor_id
group by mg.genre_id,ma.actor_id having count(*)>=3 and avg(mm.rating)>=all(
	select avg(m.rating)
    from movie m,movie_genre mog,movie_actor moa
    where mog.genre_id=mg.genre_id and mog.movie_id=m.id and moa.movie_id=m.id
    group by moa.actor_id having count(*)>=3
)
```



最后：有兴趣的同学可以运行这两种答案，比较一下速度差异，以及思考一下为什么会有这样的速度差异。

