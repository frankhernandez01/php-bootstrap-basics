/* mySQL script file to delete all tables and structures of the COMPANY DB
   The order of deleting tables is significant
   because a table cannot be deleted when another table references it.
   Normally this is a reverse sequence of the creation of tables.
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
