# Project-1

## Overview

The first project is to build an **{++information management system++}.** 

Students are required  to use a `relational database` as the underlying storage and also need to provide `a simple interface` for presenting results.

This project is an opportunity to:

* Understanding the use of databases in real-life applications
* Learn to design a `reasonable data model architecture`
* Learn how the code layer interacts with the database layer as well as the interface and logic



**Release Date:** March 26, 2021 / 15:25

**Due Date:** **{--April 23, 2021 / 17:10--} {++April 30, 2021 / 17:10++}**

---

## Specification

A basic information management system means `adding`, `deleting`, `checking` and `changing` data in specific application scenarios via an interface. **(CRUD)**

So you need to think of an information system application scenario and implement it.

Here are the specific requirements needed to complete, and to aid understanding, I will use the library management system as an example in the following sections.

<br>

### Databases

1. **You must use a `relational database`, but there are no restrictions on the exact.**

    **That means that you can use:**
    
    1. Oracle
    2. DB2
    3. SQL server
    4. Mysql
    5. postgresql
    
    Any ~~you are familiar with~~ {++you want to get familiar with++}
    
2. **The model design of the data must be reasonable**

    1. The design of the data tables is paradigm compliant

        `3NF` , `CNF`, `BCNF`... or  `Star model`, `Snowflake model`....
        
    2. The fields are designed to be reasonable and overlap with the actual as far as possible

3. Because it is up to you to decide what information system is about, **you will need to find or randomly generate your own data**
  
    In the school library management system:  `book`  `category` `location` `user` etc.



<br>

### Backend design

1. **Any language you like.**

2. **Establishing connection communication with the database for "CRUD"**

    For security, the database in the specific application is not allowed to be modified by direct access and all changes to the data have to be made through the code layer.

3. **Any modification to the data needs to be meaningful**

    In the school library management system

    1. Borrowing and returning books
    2. Buy books for storage / Book abandonment out of storage
    3. Add freshmen and delete graduates
    4. Book Location Scheduling （From Jiangwan to Handan）
    5. ......
    
4. **There are at least two different types of user and clearly defined Authority management.**

     Any information management system contains more than one type of user, so students need to implement at least two types of users with different functional privileges.

     In the school library management system:

    1. Student : Borrowing & Returning Books
    2. Teachers: Purchase 
    3. Admin: Access rights management

    !!! hint
        **The design and protection of `priviledge` is very important, so think carefully**
    

 

<br>

### Frontend Design

1. **The front-end interface can be varied, but it must be user-friendly**
    1. Web is recommanded
    2. Graphical interfaces can also be choosed : `Qt`, `Microsoft Forms applications`...
    3. No unity
2.  **Simple, easy to use and portable**



<br>

## Technology stack

Because of the `multi-user`, `multi-authority` application scenario of the information management system, we recommend you to write a web application as web pages are not restricted by the client. 

**Django**

`Full-stack` `Python`

* [Doc](https://www.djangoproject.com/start/overview/) 

    With Django, you can take Web applications from concept to launch in a matter of hours. Django takes care of much of the hassle of Web development, so you can focus on writing your app without needing to reinvent the wheel. It’s free and open source.

* Good packaging for manipulating the database

* Comes with its own back office administration page

<br>

**Flask+jinja2**

`Full-stack/Backend` `Python`

* [Doc](https://flask.palletsprojects.com/en/1.1.x/)
* Compared to django, it is `much lighter` and allows you more scope for your own design

<br>

**sqlalchemy**

`Package of Python`

* [doc](https://www.sqlalchemy.org/) 

    It provides a full suite of well known enterprise-level persistence patterns, designed for efficient and high-performing database access, adapted into a simple and Pythonic domain language.

* Good **{++Orm++}** Tools



<br>

**Bootstrap**

`hmtl` `css` `js`

* [doc](https://getbootstrap.com/) 

    Quality web front-end templates 

* Use it to optimise the interface



<br>

**Springboot**

`Full-stack/Backend` `java`

* [Doc](https://spring.io/projects/spring-boot) 

    A powerful enterprise-class framework



<br>

**Echo**

`backend` `go`

* [github](https://github.com/labstack/echo)

    a light server framework

<br>

**Egg.js**

`backend` `node.js`

* [Doc](https://eggjs.org/zh-cn/)

    better enterprise frameworks and apps with `Node.js` &` Koa`

<br>

**Frontend Framework**

`frontend` `js` `css` `html`

* **Vue.js** 

    [doc](https://cn.vuejs.org/index.html) 

* **React.js**

    [doc](https://zh-hans.reactjs.org/) 

* **Angule.js**

    [doc](https://angular.cn/docs)



----

## Submissions

1. In April 23, students will need to come to the classroom to demonstrate to TAs **in person**
2. package and uploade your application to elearning before **April 23, 2021 / 23:59**
3. A design document with:
    1. All your function points
    2. Your database design
    3. Application operating environment and how to run your project
    4. Submit two documents, one in **pdf format** and one in original format**(word, markdown)**



### Grading

| Items                                                        | Weight |
| ------------------------------------------------------------ | ------ |
| Basic score                                                  | 4      |
| Good database design                                         | 2      |
| Reasonable application scenarios and functional realisation(In particular, authority) | 2      |
| User-friendly interface                                      | 2      |
| Document                                                     | 2      |

