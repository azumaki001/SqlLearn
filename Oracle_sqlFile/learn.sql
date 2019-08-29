--查看当前CDB容器中包含的PDB容器
select name,open_mode from v$pdbs;
select name, decode(cdb, 'YES', 'Multitenant Option enabled', 'Regular 12c Database: ') "Multitenant Option" , open_mode, con_id from v$database;
select * from v$database;
select name ,con_id from v$active_services order by 1 ;
select pdb_name,status from cdb_pdbs ;

--创建共同用户
create user C##IfSample identified by IfSample container=all;
grant create session to C##IfSample;
grant create table to C##IfSample;
grant create tablespace to C##IfSample;
grant create view to C##IfSample;

select username,common,con_id from cdb_users where username like 'C##%';

--第1步：创建临时表空间
create temporary tablespace IFSAMPLE_TEMP
tempfile 'F:\000\orcleXE18c\oradata\XE\XEPDB1\IFSAMPLE_TEMP.dbf' 
size 5m autoextend on 
next 5m maxsize 2048m 
extent management local;

drop tablespace IFSAMPLE_TEMP including contents and datafiles;;

--第2步：创建数据表空间
create tablespace IFSAMPLE
logging datafile 'F:\000\orcleXE18c\oradata\XE\XEPDB1\IFSAMPLE.dbf'
size 5m autoextend on
next 5m maxsize 2048m
extent management local;

drop tablespace IFSAMPLE including contents and datafiles;;

--第3步：创建用户并指定表空间
create user IFSAMPLE identified by IFSAMPLE
default tablespace IFSAMPLE
temporary tablespace IFSAMPLE_TEMP;

grant connect,resource,dba to IFSAMPLE;
