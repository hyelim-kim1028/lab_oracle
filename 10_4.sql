/* �÷���(collection): �÷����� ���� Ÿ���� ������ �������� ������ �� ��� 

1)���� �迭 (associative array, index by table) 
- associates a unique key with a value. 
- An associative array type must be defined before array variables of that array type can be declared. 
- Data manipulation occurs in the array variable.
- key/index�� value�� ������ �����Ǵ� �÷��� 
- ���� �迭���� key/index�� binary_integer(����), pls_integer(���� ����), varchar2 (���ڿ�)Ÿ���� ���� 
-- PLS_INTEGER (plus integer) is defined in the STANDARD package as a subtype (or rather a synonym) of BINARY_INTEGER.

- �����迭�� ����(����)�ϴ� ��� 
----- type �迭�̸� is table of ������Ÿ�� index by �ε���Ÿ��; 
- index by binary_integer(����), pls_integer(���� ����), varchar2 (���ڿ�)Ÿ���� ���� (3��1) 
- ������Ÿ��: �츮�� ���� ���ڵ�, ��¥, �ð�, ����, ����... �� �� �� �ִ� 



2)��ø ���̺� (nested table)
-- nested: (of an ordered collection of sets or intervals) having the property that each set is contained in the preceding set 
and the length or diameter of the sets approaches zero as the number of sets tends to infinity. 
- Oracle stores the rows of a nested table in no particular order. But, when you retrieve the nested table into a PL/SQL variable, 
  the rows are given consecutive subscripts starting at 1. That gives you array-like access to individual rows. 
  PL/SQL nested tables are like one-dimensional arrays.
- hold an arbitrary number of elements. They use sequential numbers as subscripts. 

3)VARRAY (variable size array): specify the maximum number of elements that can be defined in the varray. 
                              the collection with any sense of a "fixed" maximum size is called the "variable size" array. 
                              

*/

set serveroutput on;

--A.�����迭 
declare 
    -- ���ڿ��� ���ҷ� ����, ���� ������ �ε����� ����ϴ� �����迭�� �������� 
    -- �迭�� �̸� ���� 
    type students is table of varchar2(20) index by pls_integer; 
    
    --������ ���� �迭 Ÿ���� ���� ���� (�迭�̸� �迭����;) 
    v_stu students; 
    
begin
    -- ���� �迭�� ������ ����: �迭�̸�(v_stu)(�ε���) := ��; 
    v_stu(1) := '������'; 
    v_stu(2) := '�����';
    v_stu(3) := '�迵��';
    
    -- ���� �迭�� ����� ����(������)�� ���� ���� ��: �迭�̸� (�ε���) 
    --dbms_output.put_line(v_stu(1)); 
    -- v_stu�� ������ �����߰�, �迭(1)�� ����� ���� �����ش� 
    -- �ε����� ������ ���ڷ� �ϴ� ����: 1�� �����ϴ� ���ڵ��� for loop �ݺ����� �� �� �ֱ� ������ 
    -- �ε����� ����� ���ļ��� �ȵǿ�!!!!!!!!!!!! 
    -- ��) 
    for i in 1..3 loop
    dbms_output.put_line(v_stu(i)); 
    end loop; 
end;
/

declare 
-- �ε��� Ÿ��: varchar2(20),������ Ÿ��:number�� ���� �迭�� ����(����) 
type cellphone is table of number index by varchar2(20); 

-- �����迭 Ÿ���� ������ ���� 
celln cellphone; 
begin 
-- �����迭�� �����͸� 3�� ���� 
celln('Spain') := 34;
celln('Korea') := 82; 
celln('Phil') := 63; 
-- �����迭�� ����� �����͸� ��� 
-- �ε����� ��ġ�� �ȵ�����, ���� ���ĵ� �ȴ� (�޴���� ¥���, «�� - �ε���, �� �ٸ�, ������ ���� �� �� 4500 �̶� no hay problema) 

dbms_output.put_line(celln('Spain'));
dbms_output.put_line(celln('Korea'));
dbms_output.put_line(celln('Phil'));

end;
/

-- ������ ���� �ФФФ̤� ����,,, 
declare 
    -- index ���� ���� ������ Ÿ�� ���� �� ���� �迭(arr_number)�� ���� 
type arr_numbers is table of number index by pls_integer; 

    -- �����迭 Ÿ���� ����(v_scores)�� ���� 
v_scores arr_numbers; 
v_sum number; -- �������� �հ踦 ������ ���� 
v_avg number; -- �������� ����� ������ ���� 
-- �� ���̵��� ����Ǿ� ���� �ʾƼ� �ȵǴ� �ſ���,,,, OMG 
-- �� ������ �ư����� � ���̺� �ִ°� �ƴ϶� �Լ� sum(), avg() �� ���� ���ϴ� �ſ���...! 
begin 
-- ���� �迭 v_scores 5���� ���� (0~100)�� �Է� 
v_scores(1) := 90;
v_scores(2) := 88;
v_scores(3) := 91;
v_scores(4) := 89;
v_scores(5) := 92;

-- v_scores.count �� �� ���̵��� ������ �����ִ� ����! 

-- for i in 1..5 loop
    --dbms_output.put_line(v_scores(i)); 
    --end loop;
    

--5���� ���� �հ踦 ����ؼ� ��� 
--select sum(v_scores) 
--into arr_numbers
--from dual;

--v_sum := v_scores(1) + v_scores(2) + v_scores(3) + v_scores(4) + v_scores(5);
-- �Լ��� ����ϴ°� �ƴ϶� ������ ����ؼ�>��� 

--dbms_output.put_line('sum = '||v_sum);

-- �迭�� ����Ǿ��� ������ �ڵ忡�� ���Ǿ����� (�� ���� �ƴ϶�) v_scores(1) not 90 
-- 10�� ���? ���ڰ� �������ٸ�? -- for loop ��� 
-- sum := 0; ���� �ʱ�ȭ 

v_sum := 0;
for i in 1..v_scores.count loop
    v_sum := v_sum + v_scores(i); 
    end loop;
    dbms_output.put_line(v_sum);

-- 5���� ������ ����� ����ؼ� ��� 
--select avg(v_scores) 
--into arr_numbers
--from ; 

--v_avg := v_sum/5;
--dbms_output.put_line('average = '||v_avg);

v_avg := v_sum / v_scores.count;
dbms_output.put_line(v_avg);
end;
/

-- �����Ͱ� n�� �ִ�,,, x1,x2,x3 ...xn 
-- ���: x1+x2+x3 ... +xn /n ...�л�...ǥ������ 

select sum(sal),avg(sal),variance(sal),stddev(sal) from emp;
-- PL/SQL ������ select into from �� ����ؼ� ���� �Լ� ��� 
-- emp ���̺��� �޿��� ����, ���, �л�, ǥ�� ������ ����ϴ� PL/SQL �� ����� �ʹ�!

--���̺� ����ִ� ���̵��� ���: utilize the functions  already existing in the system 
declare 
    v_sum number; 
    v_avg number; 
    v_var number;
    v_std number;
begin 
 select sum(sal),avg(sal),variance(sal),stddev(sal) 
 into v_sum,v_avg,v_var,v_std
 from emp;

dbms_output.put_line('v_sum: '||trunc(v_sum, 2));
dbms_output.put_line('v_avg: '||trunc(v_avg, 2));
dbms_output.put_line('v_var: '||trunc(v_var, 2));
dbms_output.put_line('v_std: '||trunc(v_std, 2));


end;
/

-- but what if the data is not in the table? 
-- a) calculate in on our own (100% articulately hand-woven codes,,,^^ ) 
-- b) create the table and utilize the function 

-- Collection Methods; 
-- �迭 ���� �̸�.count: �迭�� ������ ���� (��.v_scores.count) 
-- �迭 ���� �̸�.first: �迭�� ù��° �ε��� (��.v_scores.first) 
-- �迭 ���� �̸�.last: �迭�� ������ �ε��� (��.v_scores.last) 


-- �ε������� ���� ����, �迭�� ����(������)�� ���� Ÿ���� ���� �迭�� �����ϼ��� 
-- �����Լ��� (dbms_random.value(x,y))  trunc �Լ��� �̿��ؼ� �����迭�� 
-- for loop�� ����ؼ� �����迭�� 10�� ���� ���� 0~100������ ������ ���� 
-- 10���� ���� ������ ����, ���, �л�, ǥ������,�ִ�,�ּڰ��� ����ϴ� ���� ���� 
-- root > sqrt(); power(x,y), sqrt(x)
-- ���̺� 10���� ���� ������ insert 
-- ����� ����� sql�� �̿��� ����� ���� �� �� 

create table ex_scores(
    sid number primary key,
    score number not null
); 

declare 
type grades is table of number index by pls_integer; 

v_grades grades; 
v_sum number; 
v_avg number;
v_var number;
v_varR number; 
v_std number; 
v_max number;
v_min number; 
v_cnt constant number := 10;
v_ss number; 
-- sum of squares 

begin 
-- GET 10 arbitrary grades 
/* v_grades(1) := trunc(dbms_random.value(0,100),2);
v_grades(2) := trunc(dbms_random.value(0,100),2);
v_grades(3) := trunc(dbms_random.value(0,100),2);
v_grades(4) := trunc(dbms_random.value(0,100),2);
v_grades(5) := trunc(dbms_random.value(0,100),2);
v_grades(6) := trunc(dbms_random.value(0,100),2);
v_grades(7) := trunc(dbms_random.value(0,100),2);
v_grades(8) := trunc(dbms_random.value(0,100),2);
v_grades(9) := trunc(dbms_random.value(0,100),2);
v_grades(10) := trunc(dbms_random.value(0,100),2);*/

-- is the same as 

for i in 1..v_cnt loop 
    v_grades(i) := trunc(dbms_random.value(0,101),0);
    end loop;
-- 101�� ����: 0,100 > 0���� 99.999999 ... �׷��� 101 > 100 ������ �������ֱ����ؼ� 

-- demonstrate the random grades 
/* dbms_output.put_line(v_grades(1));
dbms_output.put_line(v_grades(2));
dbms_output.put_line(v_grades(3));
dbms_output.put_line(v_grades(4));
dbms_output.put_line(v_grades(5));
dbms_output.put_line(v_grades(6));
dbms_output.put_line(v_grades(7));
dbms_output.put_line(v_grades(8));
dbms_output.put_line(v_grades(9));
dbms_output.put_line(v_grades(10));*/

-- is also the same as: 

for i in 1..v_grades.count loop 
    dbms_output.put_line(i || ' : '||v_grades(i));
    end loop;
-- �� ������ �ФФФ̤̤� ������Ƥä�;���������Ӥ���T


-- ex_scores ���̺� ������ �������� insert 
delete from ex_scores; --���̺� �����Ͱ� �ִٸ� ���� ���� 

for i in 1..v_grades.count loop 
 insert into ex_scores values (i,v_grades(i));
   end loop; 
    commit;   
-- ���� ���̺� �����Ͱ� �����ϱ� �Լ���� ������ �ҷ��� �� ���� 

-- ���� �������� �����跮 (descriptive statistics) ������
select sum(score),avg(score),trunc(variance(score),2),trunc(stddev(score),2),max(score),min(score) 
into v_sum, v_avg,v_var,v_std,v_max,v_min 
from ex_scores;

-- into �ư��� v_sum, v_avg,v_var,v_std,v_max,v_min ������ record�� ����� > �װ� constant �� �ᵵ ������ 

-- ���� �������� �����跮 (descriptive statistics) Ȯ�� 
dbms_output.put_line('SUM: '||v_sum||' , '||'AVG: '||v_avg||' , '||
                     'VARIANCE: '||v_var||' , '||'STANDARD VARIANDE: '||v_std||' , '||
                      'MAX: '||v_max||' , '||'MIN: '||v_min);
                      


-- calculate for its sum 
v_sum := 0;
for i in 1..v_grades.count loop
    v_sum := v_sum + v_grades(i); 
    end loop;
    dbms_output.put_line('SUM: '||v_sum);



-- calculate the avg 
v_avg := v_sum / v_grades.count;
dbms_output.put_line('AVG: '||v_avg);



-- calculate the variance 
/*v_ss := 0; 
for i in 1..v_grades.count loop
    v_ss := v_ss + (v_avg - v_grades(i))**2;
end loop; 
v_var := trunc(v_ss/(v_grades.count -1),2); 
dbms_output.put_line('VARIANCE: '||v_var);*/

for i in 1..v_grades.count loop 
   v_var := power((v_avg - v_grades(i)),2);
    end loop;
    dbms_output.put_line('VAR: '||v_var);
    v_varR := trunc(v_var * (1/(v_grades.count-1)),2);
    dbms_output.put_line('VARR: '||v_varR);
 

-- calculate the standard deviation: sqrt(v_varR)
v_std := trunc(sqrt(v_var),2);
dbms_output.put_line('STD: '||v_std);
    
    
--calculate for the max number  

/*
for i in 1..v_grades.count loop 
    v_max := v_grades(i);
    if v_max > v_grades(i) then 
    end if; 
    dbms_output.put_line('MAX: '||v_max);
    end loop;
    


--calculate for the min number  
/*v_min := v_grades(i); 
for i in 1..v_grades.count loop 
    if v_min > v_grades(i)then 
    dbms_output.put_line('MIN: '||v_min);
    end if;
    end loop;*/
    
    
end;
/


 