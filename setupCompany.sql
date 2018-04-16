/* Company database mySQL data definition.
   Ordering of tables is important
   since a table can reference tables that are defined before.
   Since date type is not available in MySQL,
     create a new user defined data type date as char(10).
*/

/* Phase 1: Drop all six tables of Company database if they exist
    in the correct sequence without violating foreign key constraints
*/

-- if dependent table already exists, remove the table
  drop table if exists dependent;

-- if works_on table already exists, remove the tablema

  drop table if exists works_on;

-- if project table already exists, remove the table
  drop table if exists project;

-- if dept_locations table already exists, remove the table
  drop table if exists dept_locations;

-- if employee table already exists, remove the table
  drop table if exists employee;

-- if department table already exists,department remove the table
  drop table if exists department;

/* Phase 2: Create all six empty tables of Company database */

-- create a new empty table department
create table department
( dname		varchar(15)	not null,
  dnumber	int		not null,
  mgrssn	char(9)		not null,
  mgrstartdate	char(10),
  constraint deptpk
    primary key (dnumber),
  constraint deptsk
    unique (dname)
/*constraint deptmgrfk
    foreign key (mgrssn) references employee(ssn)
  This foreign key has been commented out since the dbms does not
  support mutual foreign keys between department and employee tables */
);

-- create a new empty table employee
create table employee
( fname		varchar(15)	not null,
  minit		char,
  lname		varchar(15)	not null,
  ssn		char(9)		not null,
  bdate		char(10),
  address	varchar(30),
  sex		char,
  salary	decimal(10,2),
  superssn	char(9),
  dno		int		not null,
  constraint emppk
    primary key (ssn),
/*constraint empsuperfk
    foreign key (superssn) references employee(ssn),
  This foreign key constraint among columns of the same table
   has not been supported by MS-SQL */
  constraint empdeptfk
    foreign key (dno) references department(dnumber)
);

-- create a new empty table dept_locations
create table dept_locations
( dnumber	int		not null,
  dlocation	varchar(15)	not null,
  constraint dlocpk
    primary key (dnumber, dlocation),
  constraint dlocdeptfk
    foreign key (dnumber) references department(dnumber)
);

-- create a new empty table project
create table project
( pname		varchar(15)	not null,
  pnumber	int		not null,
  plocation	varchar(15),
  dnum		int		not null,
  constraint projpk
    primary key (pnumber),
  constraint projsk
    unique (pname),
  constraint projdeptfk
    foreign key (dnum) references department(dnumber)
);

-- create a new empty table works_on
create table works_on
( essn		char(9)		not null,
  pno		int		not null,
  hours		decimal(3,1)	not null,
  constraint workpk
    primary key (essn, pno),
  constraint workempfk
    foreign key (essn) references employee(ssn),
  constraint workprojfk
    foreign key (pno) references project(pnumber)
);

-- create a new empty table dependent
create table dependent
( essn		char(9)		not null,
  dependent_name varchar(15)	not null,
  sex		char,
  bdate		char(10),
  relationship	varchar(8),
  constraint deppk
    primary key (essn, dependent_name),
  constraint depempfk
    foreign key (essn) references employee(ssn)
);


/* Phase 3: Add rows of data to each of these six empty tables of Company DB */

-- Insertion of three department rows
INSERT INTO department
VALUES
('Research','5','333445555','1988-05-22');
INSERT INTO department
VALUES
('Administration','4','987654321','1995-01-01');
INSERT INTO department
VALUES
('Headquarters','1','888665555','1981-06-19');

-- Insertion of eight employee rows
INSERT INTO employee
VALUES
('James','E','Borg','888665555','1937-11-10','450 Stone, Houston, TX','M','55000','','1');
INSERT INTO employee
VALUES
('Franklin','T','Wong','333445555','1955-12-08','638 Voss, Houston, TX','M','40000','888665555','5');
INSERT INTO employee
VALUES
('Jennifer','S','Wallace','987654321','1941-06-20','291 Berry, Bellaire, TX','F','43000','888665555','4');
INSERT INTO employee
VALUES
('John','B','Smith','123456789','1965-01-09','731 Fondren, Houston, TX','M','30000','333445555','5 ');
INSERT INTO employee
VALUES
('Ramesh','K','Narayan','666884444','1962-09-15','975 Fire Oak, Humble, TX','M','38000','333445555','5');
INSERT INTO employee
VALUES
('Joyce','A','English','453453453','1972-07-31','5631 Rice, Houston, TX','F','25000','333445555','5');
INSERT INTO employee
VALUES
('Alicia','J','Zelaya','999887777','1968-01-19','3321 Castle, Spring, TX','F','25000','987654321','4');
INSERT INTO employee
VALUES
('Ahmad','V','Jabbar','987987987','1969-03-29','980 Dallas, Houston, TX','M','25000','987654321','4');

-- Insertion of five dept_locations rows
INSERT INTO dept_locations
VALUES
('1','Houston');
INSERT INTO dept_locations
VALUES
('4','Stafford');
INSERT INTO dept_locations
VALUES
('5','Bellaire');
INSERT INTO dept_locations
VALUES
('5','Sugarland');
INSERT INTO dept_locations
VALUES
('5','Houston');

-- Insertion of six project rows
INSERT INTO project
VALUES
('ProductX','1','Bellaire','5');
INSERT INTO project
VALUES
('ProductY','2','Sugarland','5');
INSERT INTO project
VALUES
('ProductZ','3','Houston','5');
INSERT INTO project
VALUES
('Computerization','10','Stafford','4');
INSERT INTO project
VALUES
('Reorganization','20','Houston','1');
INSERT INTO project
VALUES
('Newbenefits','30','Stafford','4');

-- Insertion of sixteen works_on rows
INSERT INTO works_on
VALUES
('123456789','1','32.5');
INSERT INTO works_on
VALUES
('123456789','2','7.5');
INSERT INTO works_on
VALUES
('666884444','3','40.0');
INSERT INTO works_on
VALUES
('453453453','1','20.0');
INSERT INTO works_on
VALUES
('453453453','2','20.0');
INSERT INTO works_on
VALUES
('333445555','2','10.0');
INSERT INTO works_on
VALUES
('333445555','3','10.0');
INSERT INTO works_on
VALUES
('333445555','10','10.0');
INSERT INTO works_on
VALUES
('333445555','20','10.0');
INSERT INTO works_on
VALUES
('999887777','30','30.0');
INSERT INTO works_on
VALUES
('999887777','10','10.0');
INSERT INTO works_on
VALUES
('987987987','10','35.0');
INSERT INTO works_on
VALUES
('987987987','30','5.0');
INSERT INTO works_on
VALUES
('987654321','30','20.0');
INSERT INTO works_on
VALUES
('987654321','20','15.0');
INSERT INTO works_on
VALUES
('888665555','20','0.0');

-- Insertion of seven dependent rows
INSERT INTO dependent
VALUES
('333445555','Alice','F','1986-04-05','daughter');
INSERT INTO dependent
VALUES
('333445555','Theodore','M','1983-10-25','son');
INSERT INTO dependent
VALUES
('333445555','Joy','F','1958-05-03','spouse');
INSERT INTO dependent
VALUES
('987654321','Abner','M','1942-02-28','spouse');
INSERT INTO dependent
VALUES
('123456789','Michael','M','1988-01-04','son');
INSERT INTO dependent
VALUES
('123456789','Alice','F','1988-12-30','daughter');
INSERT INTO dependent
VALUES
('123456789','Elizabeth','F','1967-05-05','spouse');

/* End of Company database script */
