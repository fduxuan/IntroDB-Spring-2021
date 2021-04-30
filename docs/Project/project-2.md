# Project-2: MyJQL

In this project, you are going to implement a toy database which supports B-Tree indexing in C. You can use any system calls available in Ubuntu but you cannot link to any external libraries.

## Introduction to MyJQL

MyJQL is a simplified database which has only one table of two columns. Its only table is defined to be:

|Column|Type|
|:-:|:-:|
|`A`|`int`|
|`B`|`varchar(11)`|

> `A` is an unsigned 31-bit integer, and `B` consists of the english alphabets and the numerical digits.

B-Tree index is automatically created for column `B`.

To run the database, you must specify the database file. If the database program is `myjql`, and the database file is `myjql.db` (which will be automatically created if it does not exist), you start the database by running `./myjql myjql.db`. In this way, if you exit the database and restart it later with the same database file, your data will persist (instead of losing after exiting).


## JQL Syntax & Shell IO Format

**You must strictly follow the IO format, or you will fail all the tests! You may assume all the input is valid so that you don't need to handle any error.**

### Prompt

The database prints `"myjql> "` (no trailing new-line character `'\n'`) to wait for the input.

### Listing Order

Since you are going to list the records, the listing order is crucial. Basically, the rules are:
- The records are sorted by `B` in ascending order (determined by `strcmp`).
- If there are multiple records with the same `B`, these records are sorted by their time of insertion in descending order (The latest record will be listed first).

### Format of Records

The format for any record is: `(A, B)` followed by `'\n'` (`Space` `' '` is after the `','`, not `Tab` `'\t'` or any other). `A` and `B` are not enclosed in quotes `'` or `"`.

When you are printing *a list of records*, it will be `"(Empty)\n"`, if there are no records; or, use the format above to print the record(s) in the order mentioned earlier.

### Supported JQLs

- `select`: List all the records.
  - Output: `'\n'` followed by *a list of records*, and finally `"\nExecuted.\n\n"`.
- `select s`: Find the record(s) whose `B = s`.
  - Output: `'\n'` followed by *a list of records* satisfying the select criterion, and finally `"\nExecuted.\n\n"`.
- `insert i s`: Insert a record with `A = i`, `B = s`.
  - Output: `"\nExecuted.\n\n"`.
- `delete s`: Delete the record(s) whose `B = s`.
  - Output: `"\nExecuted.\n\n"`.
- `.exit`: Exit the database. This will always be the last input.
  - Output: `"bye~\n"` (no leading new-line character `'\n'`).

> `i` and `s` are both valid and they are not enclosed in quotes `'` or `"`.


## Sample Usage

Start your database (assuming `myjql.db` does not exist):
```
./myjql myjql.db
```

The interactions between you and your database are listed as follows:
```
myjql> select

(Empty)

Executed.

myjql> insert 1 a

Executed.

myjql> insert 2 b

Executed.

myjql> insert 3 d

Executed.

myjql> insert 4 c

Executed.

myjql> select

(1, a)
(2, b)
(4, c)
(3, d)

Executed.

myjql> insert 5 b

Executed.

myjql> insert 6 b

Executed.

myjql> select

(1, a)
(6, b)
(5, b)
(2, b)
(4, c)
(3, d)

Executed.

myjql> select b

(6, b)
(5, b)
(2, b)

Executed.

myjql> delete b

Executed.

myjql> select

(1, a)
(4, c)
(3, d)

Executed.

myjql> select b

(Empty)

Executed.

myjql> delete e

Executed.

myjql> select

(1, a)
(4, c)
(3, d)

Executed.

myjql> .exit
bye~
```

Now, restart your database (without deleting `myjql.db`):
```
./myjql myjql.db
```

The interactions between you and your database are listed as follows:
```
myjql> select

(1, a)
(4, c)
(3, d)

Executed.

myjql> .exit
bye~
```


## Grading Method

Total: **10** points

You will get the points one step after another in the following order:

- If you 1) implement a B-Tree structure which can be serialized into (and deserialized from) the disk file, and 2) pass both the preliminary test (which you can download `pj-2-pre-test.zip` from the files in elearning) and the manual test (for database basic functions and persistence check), you have **5** points.
- If you pass the final test (which will not be provided) within the time limit, you have **3** points.
- If you pass the final test within the memory limit, you have **2** points.

> Pass a test means that the output of your database should be completely identical to that of the standard database.

> Standard database refers to my implementation.

> Disk space is unlimited.


## Testing Method

- Computer Hardware:
  - CPU: Intel Xeon Silver 4114 @ 2.20GHz
  - RAM: 128GB
- Operating System: Ubuntu 18.04.3 LTS
- GCC Version: 7.5.0
- Compiling: `gcc -o myjql myjql.c -O3`
- Executing: `/usr/bin/time -v ./myjql myjql.db < in.txt > out.txt`
- Comparing: `diff out.txt ans.txt`
  - There should be no differences.

> Important metrics for the standard database:
> ```
> Elapsed (wall clock) time (h:mm:ss or m:ss): 1:06.98
> Maximum resident set size (kbytes): 1768
> ```
> Your time limit and your memory limit are set to be `3:00.00`, and `6000`, respectively.


## Submission

What you have to submit: a zip archive named `[student_id]-[name]-pj-2.zip`. When unzip it with `unzip [student_id]-[name]-pj-2.zip`. We should have the following directory structure:

```
[student_id]-[name]-pj-2
|- doc.pdf
|- myjql.c
```

> Your document should well explain the architecture of your database, and the algorithms for B-Tree operations if it is specially optimized.

You should submit your zip archive to the corresponding assignment in elearning.
