-- ���ڿ� �Լ� 
-- �Լ� ȣ���� ����� ����ϱ� ���� ���� ���̺�: dual 
select upper ('Sql Course')from dual;
-- �Լ�ȣ��: �Լ� (function) (��ȣ �ȿ� ��/ argument); �׸��� ����� (i.e. SQL COURSE) �� ���� 
-- this is a dummy table, in oracle you cannot get a return value immediately 
-- (i.e. upper('sql course'); does not work this way)
select lower ('Sql Course') from dual;
select initcap ('Sql Course') from dual;

-- ������ �Լ� ���� 
select ename, upper(ename), lower(ename), initcap(ename)
from emp;

select job, lower(job), initcap(job)
from emp;

-- upper, lower, initcap�� �˻��� �� ���� ���; �׷��� �˻��� ���õ� sql�� ���� ������ 
-- For instance, if you write a comment like a below where ename is in lowercase, 
-- the SQL won't give any result back 
select * from emp 
where ename='scott';
-- so, we can try like:  
select * from emp 
where ename = upper('scott');
-- but this is also dangerous, because in a big data you won't know if letters are all in lower/upper cases
-- now, 
select*from emp
where upper(ename) = upper('scott');
-- so you standardize it with both capital letters using the function upper 

-- ���� �̸� �߿� la��� �ϴ� �α��ڰ� ���Ե� ��� �������� ������ ����غ��ƶ� 
select * from emp 
where lower (ename) like lower ('%la%');
-- = �� �ƴ� like �� �˻� (����: ���� ���� ã�� ���� �ƴ϶�, ������ ã�� ���̱� ������!!!!) 


select concat('hello','world') from dual;
-- substr (���ڿ�, �����ε���, ���ڰ���) (�����ε���: ��� ���� ¥������, ���ڰ���: ����� ¥������)
select substr ('HelloWOrld',1,5) from dual;
--HELLO 
--12345 
--H = index 1, E=index 2, .. 
select substr ('HelloWorld',2,5) from dual;
select substr ('HelloWorld',2) from dual;
-- ���� ��ɿ����� ��� ©���� ���� �ʾҴ�, ��𼭺��ʹ� �ִ�. �̷� ���� 2������ ������ �߶�´� 
-- refined phrase: ����° argument�� �߶� ���� ������ �������� �ʴ� ��쿡�� 
-- ���ڿ����� �����ε������� �� ���ڿ��� ������ �߶� 
select substr('http://www.google.com',8) from dual;

--length(���ڿ�)***���� ����ǥ!
select length ('HelloWOrld')from dual;
select length('�ѱ�')from dual;
--  ���ڰ����� ����Ʈ�� �ٸ��� / length�� ���� ���� �ִ� �� 
select lengthb('�ѱ�')from dual;
-- lengthb (byte length?), then �ѱ�'s ���ڰ��� is 2 and byte is 4 
select length ('Hello'), lengthb ('Hello') from dual;
select length('�ѱ�'),lengthb('�ѱ�') from dual;

--emp���̺��� �����̸��� 6���� �̻��� �������� ��� ���ڵ� ��� 
-- My guess: FAIL: select * from emp where legnth (ename>6);
select ename from emp where length(ename)>5;

select instr ('HelloWorld','W') from dual;
-- ���� �����Ϳ��� w�� (������)�� ���°�� �ִ����� �˾ƺ��� 
-- instr ���� ���� / W > ã�� ���� 
select instr ('HelloWorld','w') from dual;
-- result: 0 ; ���ڿ� �ȿ� �����ϴ� (w in the given is an uppercase but the search word is a lowercase letter)
select instr(lower('HelloWorld'),'w') from dual;
-- Success. this is because we tried to find w after converting the HelloWorld to all lower cases 
select instr ('HelloWorld','l') from dual;
-- HelloWorld ���� l�� 3�� �ִ�. inst�� ù��°���� ã�� �����ؼ�, ������ ���� �ʰ� ó�� ã���� ���� 
select instr ('HelloWorld','l',5) from dual; 
-- (���ڿ�, ã�� ����, �ε������° ���� ã���ּ���) 

select lpad('hello',10,'*') from dual;
--lpad(����, ���ڸ� ����ϱ� ���� ������ �ڸ��� ����, �� ������ ä�� ����)  
--result : ������ �����ʿ� �Ǿ��ְ�, ���ʿ� ������ �ִ� (�ٵ� �� �߰����� ���̴°� ���ſ�ΰ�?) 
-- ���ʿ� ������ �����ִ´� _ _ _ _ _ _ _ _ _ _ > _ _ _  _ _ h e l l o 

select rpad('hello',10) from dual;
--rpad(����, ...) 
--result: ������ ���ʿ� �Ǿ��ְ�, �����ʿ� ������ �ִ� 
-- *****hello ����� �ǰ� ��й�ȣ �ֹι�ȣ ó�� ���屺 ~^^* 

select rpad(substr('hello',1,1),length('hello'),'*') from dual;

select rpad(substr(ename,1,1),length('ename'),'*') from emp;

select replace('JACK and JUE','J','BL') from dual;
--(��������, J�� ã�Ƽ�, BL �� �ٲ��) 

--trim: ó���� ���� �ִ� ���� ���ĺ��� ����� 
select trim('H' from 'HelloWorld') from dual;
--elloWorld
select trim('a' from 'anneMaria')from dual;
-- nneMari 

select trim('h' from 'hhello hello ollehhhhh')from dual;
--ello hello olle 
select trim('h' from 'hello olleh')from dual;
--ello olle 
-- trimp: �˻� ��� ������ ����. �յڿ��ִ� �ʿ���� ������� ©����� �� 
select trim(' ' from '         hello hello olleh        ')from dual;
select trim(' ' from '         hello     hello    olleh        ')from dual;

--���� ���� �Լ� 
select round(1234.5678,0),round(1234.5678,1),round(1234.5678,2),
 round(1234.5678,-1), round(1234.5678, -2) from dual;
-- you must give two arguments
select round(1234.5678,1) from dual;
-- �Ҽ��� 1�ڸ� ���� 
-- (������, �Ҽ��� ����� �� ���̳�) + �ݿø��� �ض� 
-- -1�� 1�� �ڸ����� �ݿø��� ��Ű��, -2�� 10�� �ڸ����� �ݿø��� ��Ű��
select trunc(1234.5678,0),trunc(1234.5678,1),trunc(1234.5678,2),
 trunc(1234.5678,-1), trunc(1234.5678, -2),trunc(1234.5678, -4) from dual;

--mod(): ���� �������� ��� 
select mod(7,3) from dual;
select 7/3 from dual;
select trunc(7/3,0), mod(7,3) from dual;

select ceil(3.14), floor(3.14) from dual;
-- ceil�� õ��, ��� �ø�, floor�� �ٴ�, ��� ����
-- 3.14 �� ���ԵǾ��ִ� ���ڱ����� 3�� 4 ����, �׷��� ceil�� 4, floor �� 3�� �ȴ� 
select ceil(-3.14), floor(-3.14) from dual;

-- ��¥ ���� �Լ� 
-- ��¥(date)Ÿ���� ���� SQL Developer�� ȯ�漳������ ������ �������� ��µ�
-- ���� > ȯ�漳�� > �����ͺ��̽� > NLS (National Language Support) ���� sysdate ���� �ٲ� �� ���� 
-- ��¥ �����͸� ���ϴ� �������� ����ϰ� ���� �� to_char(��¥, ����)�Լ��� ��� 
select sysdate from dual;
select add_months(sysdate, 1)from dual;
select add_months(sysdate,10) from dual;

select sysdate + 1 from dual; 
-- add month �� �ִµ�, add day�� ����. �̷����ϸ� ���� �� ���� :) 
select sysdate + 2 from dual;
select add_months(sysdate+2,4) from dual;
-- �˾Ƽ� �״� ���Ϸ� ���� 
-- -1 �� ������ ���� 
select sysdate -1 from dual;

select months_between(sysdate,hiredate)
from emp;
-- today - hiredate = + 

select months_between(hiredate,sysdate)
from emp;
-- hiredate - today = - 

--round �� �� ������ ������ ��������Ѵ� 
-- ������ ���� 
select round(sysdate, 'YYYY') from dual;
select round(sysdate, 'YYYY'), round(sysdate,'Q') from dual;
-- Q = Quarter (4�б�): 1/1,4/1,7/1,10,1 
select trunc(sysdate, 'YYYY'), trunc(sysdate,'Q') from dual;
-- ������ ©������� �Ŵϱ�, ������ ���� �����ɷ� ���� 

-- ������ Ÿ�� ��ȯ �Լ� 
--to_char():���ڿ��� ����
--to_number():���ڸ� ���� > ���ڿ��� ����Ÿ������ �ٲ��� 
--to_date():��¥�� ���� > ���ڿ��� �޾Ƽ�, �װ� ��¥���� ������ִ� 
-- �츮�� ���ϴ� �Լ��� ����ϰ� ���� ��? 

-- ����Ŭ���� ��Ģ������ (+,-,*,/) �� ���� Ÿ�Կ����� ��� �� �� �ִ� (date type�� +,- ����) 
select '1000' + '100' from dual;
-- ��ǻ�ʹ� '1000'�� 1 0 0 0 ���� �̷���� ���ڷ� �ν��Ѵ�, 100 �� �������� 
-- ������, ����� �����ߴ�..! > �̷� ��� ���ڷ� ��ȯ �� �� �ִ� ���ڿ��� ������ ��ȯ�� �����ϴ� 
-- ����Ŭ�� ���ڷ� ��ȯ�� �� �ִ� ���ڿ����� ��쿡�� ���������� Ÿ�� ��ȯ�� ������ �� ��Ģ ���� ����� �� 
select '1000' + 'abc' from dual;
--FAIL. the characters cannot be calculated like numbers 
--���ڷ� ��ȯ�� �� ���� ������ ��� ��Ģ ������ �ϸ� invalid number �̶�� �ϴ� ������ �߻���Ŵ
select'1,000'+'100' from dual;
-- FAIL. '1,000'�� ���ڶ�� �ν��ϰ�, '100'�� ���ڶ�� �νĵǾ ��� �Ұ���. , ������ 1000�� ���ڷ� ��ȯ�� �Ұ��ϴ�...! 
select to_number('1,000','9,999') + to_number('100','999') 
from dual;
-- argument �� �ݵ�� 2���� �־���ϰ�, ('1,000','9,999') (���ڷ� ��ȯ�� �Ǿ�� �� ����, ��� �������)
select to_number('12,000','9,999') + to_number('100','999') 
from dual;
-- FAIL. the function cannot convert 12,000 to a number because of the argument input we made was only up to thousands '9,999'
-- SO, we can make it function by making 9,999 to a larger number 
select to_number('12,000','99,999') + to_number('100','999') 
from dual;

-- ��¥(date)Ÿ���� ���� SQL Developer�� ȯ�漳������ ������ �������� ��µ�
-- ���� > ȯ�漳�� > �����ͺ��̽� > NLS (National Language Support) ���� sysdate ���� �ٲ� �� ���� 
-- ��¥ �����͸� ���ϴ� �������� ����ϰ� ���� �� to_char(��¥, ����)�Լ��� ��� 
-- ��¥>���ڷ� to_character 
select sysdate from dual;
select sysdate, 
       to_char(sysdate,'YY-MM-DD')
       from dual;
-- Result: the sysdate as set by the admin, to_cahr is a little twist from the comment above 

select sysdate,
        to_char(sysdate,'YY-MM-DD'),
       to_char(sysdate,'AM HH:MI:SS')
       from dual;
-- 'AM HH:MI:SS' or 'HH:MI:SS AM': any order is possible 
-- use AM/PM alternatively, it does not affect the time 

select sysdate,
       to_char(sysdate,'YY-MM-DD'),
       to_char(sysdate,'AM HH:MI:SS'),
       to_char(sysdate,'DY'),
       to_char(sysdate,'DAY')       
       from dual;
--DY �� ���Ӹ��� ǥ�� ������ > ��, DAY�� complete�ϰ� �����Ϸ� ǥ�� 
-- RR�̳� YY�� ��¥�� �Ȱ��� ��Ÿ����  

-- ������ ����� �ٲپ��� ��, MM (01,09,�̷������� ��Ÿ��) > MON (JAN,MAR �̷������� ��Ÿ��) 
-- ��-��-�� (�̱�), ��-��-�� (����), ��-��-��(�ѱ�)
-- ����-��-��-��-��-��-�� (�ð��� 7����Ʈ) 

-- �ݴ��, �츮�� ��¥�� ������ ���̽��� �Է� �� ��, Ű����� �Է��ϸ� �װ� �ᱹ ���ڿ�> �װ� ���ڷ� ������ �Ǿ���Ѵ� 
-- ���ڿ��� ��¥�� ��ȯ���ִ� �Լ� to_date 
-- to_date�� �⺻�� NLS�� ���󰣴� 
--to_date(���ڿ�, ��¥����) 
select to_date ('2019/08/29') from dual; 
-- SUCCESS. ���ڿ��� �ð��� �°� ����� �� 
select to_date ('19/08/29') from dual; 
-- FAIL. 4�ڸ� �ε�, �׳� 19�� (A.c.19) > �ǰ� ������ �� �̴� 
-- writing a comment related to date without knowing its setting is dangerous 
select to_date ('2019/08/29','YYYY/MM/DD'),
       to_date ('19/08/29','YY/MM/DD') 
       from dual;
-- SUCCESS. �̷��� �ϸ� �⺻ ���� ������� ���� :) 
-- YY�� ���� ���� + �ڿ� �⵵ �� �ڸ� 
select to_date ('2019/08/29','YYYY/MM/DD'),
       to_date ('99/08/29','YY/MM/DD') 
       from dual;
-- �̷��� �ϸ� ('99/08/29','YY/MM/DD') �� 2099�� 8�� 29�Ϸ� ��µȴ�. YY�� ���� ���� + ���ڸ� �ΰ�! �������� 
--RR ���⾲? 1950~2049 

select to_date('50/08/29','RR/MM/DD') from dual; 
-- ���� ��¥�� 2019���̶�,�ݿø��� �Ǵ� ���ڰ� �̰�. 1800���, 19100���, ���� �� ���� 
-- 2050�⿡ �츮�� ����Ŭ�� ���, �׷��� �� �� 2050~2149���� 100 �� �����ϱ� 
-- ��, RR�� 100�� ������ ��� �����ϴ� �ű��� 
-- ���ڿ� �ڿ� �׻� ���䵵 �Բ� �������ִ� ���� �����ϴ� 

select to_date('05:10:15','HH:MI:SS')
from dual;

select to_date('17:10:15','HH:MI:SS')
from dual;
--FAIL. HH�� 24�ð����� ������� �ʾұ� ������ ������ ����!! 

select to_date('17:10:15','HH24:MI:SS')
from dual;

--null ���� ó���ϴ� �Լ� 
-- ��� ���� ��, null�� �����ϰ� ���� �ִ� �͵��� ���ؼ� �� �� ��ŭ �����ش� 
-- null value 
-- nvl(����,null�� ��ü�� ��)/ ���� = column 
-- nvl2 (����, null�� �ƴ� �� ��ü�� ��, null�� �� ��ü�� ��) 

select comm,nvl(comm,0), nvl2(comm,'TRUE','FALSE') from emp;
--nvl(comm,X) FAIL 

desc emp;
-- ���� comm�� ���ڸ� ����, �׷��� nvl���� 0Ȥ�� ���ڸ� ����  
-- nvl2������ (comm,'A','B'), A�� B�� �ڸ��� ���ڳ���, ���ڳ����� ���� 
-- ��) 1,FALSE, TRUE,0 �̷������� �ȵ� TRUE,FALSE; O,X; comm,0 �̷������� ���ڴ� ���ڳ���, ���ڴ� ���ڳ����� ���� 
-- �ֳ��ϸ� column�� ���� Ÿ�Ը� �����ϴϱ� 
-- ������ ����ȯ�� �Ͼ �� �ִ� 


