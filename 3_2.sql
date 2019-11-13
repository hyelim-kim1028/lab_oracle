-- 문자열 함수 
-- 함수 호출의 결과를 출력하기 위한 더미 테이블: dual 
select upper ('Sql Course')from dual;
-- 함수호출: 함수 (function) (괄호 안에 값/ argument); 그리고 결과값 (i.e. SQL COURSE) 이 나옴 
-- this is a dummy table, in oracle you cannot get a return value immediately 
-- (i.e. upper('sql course'); does not work this way)
select lower ('Sql Course') from dual;
select initcap ('Sql Course') from dual;

-- 단일행 함수 예제 
select ename, upper(ename), lower(ename), initcap(ename)
from emp;

select job, lower(job), initcap(job)
from emp;

-- upper, lower, initcap은 검색할 때 많이 사용; 그래서 검색과 관련된 sql을 만들 때에는 
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

-- 직원 이름 중에 la라고 하는 두글자가 포함된 모든 직원들의 정보를 출력해보아라 
select * from emp 
where lower (ename) like lower ('%la%');
-- = 이 아닌 like 로 검색 (이유: 같은 것을 찾는 것이 아니라, 패턴을 찾는 것이기 떄문에!!!!) 


select concat('hello','world') from dual;
-- substr (문자열, 시작인덱스, 문자갯수) (시작인덱스: 언디서 부터 짜를꺼냐, 문자갯수: 몇개까지 짜를꺼냐)
select substr ('HelloWOrld',1,5) from dual;
--HELLO 
--12345 
--H = index 1, E=index 2, .. 
select substr ('HelloWorld',2,5) from dual;
select substr ('HelloWorld',2) from dual;
-- 위의 명령에서는 몇개를 짤라라는 주지 않았다, 어디서부터는 있다. 이럴 때는 2번부터 끝까지 잘라냈다 
-- refined phrase: 세번째 argument인 잘라낼 문자 갯수를 전달하지 않는 경우에는 
-- 문자열에서 시작인덱스부터 그 문자열의 끝까지 잘라냄 
select substr('http://www.google.com',8) from dual;

--length(문자열)***작은 따옴표!
select length ('HelloWOrld')from dual;
select length('한글')from dual;
--  글자갯수와 바이트는 다르다 / length는 글자 수만 주는 것 
select lengthb('한글')from dual;
-- lengthb (byte length?), then 한글's 글자개수 is 2 and byte is 4 
select length ('Hello'), lengthb ('Hello') from dual;
select length('한글'),lengthb('한글') from dual;

--emp테이블에서 직원이름이 6글자 이상인 직원들의 모든 레코드 출력 
-- My guess: FAIL: select * from emp where legnth (ename>6);
select ename from emp where length(ename)>5;

select instr ('HelloWorld','W') from dual;
-- 원본 데이터에서 w류 (지정값)이 몇번째에 있는지를 알아보는 
-- instr 원본 변수 / W > 찾을 문자 
select instr ('HelloWorld','w') from dual;
-- result: 0 ; 문자열 안에 없습니다 (w in the given is an uppercase but the search word is a lowercase letter)
select instr(lower('HelloWorld'),'w') from dual;
-- Success. this is because we tried to find w after converting the HelloWorld to all lower cases 
select instr ('HelloWorld','l') from dual;
-- HelloWorld 에는 l이 3개 있다. inst은 첫번째부터 찾기 시작해서, 끝까지 가지 않고 처음 찾으면 끝남 
select instr ('HelloWorld','l',5) from dual; 
-- (문자열, 찾을 문자, 인덱스몇번째 부터 찾아주세요) 

select lpad('hello',10,'*') from dual;
--lpad(글자, 글자를 출력하기 위해 마련한 자리의 개수, 빈 공간을 채울 무언가)  
--result : 정렬이 오른쪽에 되어있고, 왼쪽에 공백이 있다 (근데 좀 중간으로 보이는건 기분탓인가?) 
-- 왼쪽에 공백을 끼워넣는다 _ _ _ _ _ _ _ _ _ _ > _ _ _  _ _ h e l l o 

select rpad('hello',10) from dual;
--rpad(글자, ...) 
--result: 정렬이 왼쪽에 되어있고, 오른쪽에 공백이 있다 
-- *****hello 생긴게 되게 비밀번호 주민번호 처럼 생겼군 ~^^* 

select rpad(substr('hello',1,1),length('hello'),'*') from dual;

select rpad(substr(ename,1,1),length('ename'),'*') from emp;

select replace('JACK and JUE','J','BL') from dual;
--(원문문자, J를 찾아서, BL 로 바꿔라) 

--trim: 처음과 끝에 있는 지정 알파벳만 지운다 
select trim('H' from 'HelloWorld') from dual;
--elloWorld
select trim('a' from 'anneMaria')from dual;
-- nneMari 

select trim('h' from 'hhello hello ollehhhhh')from dual;
--ello hello olle 
select trim('h' from 'hello olleh')from dual;
--ello olle 
-- trimp: 검색 기능 때문에 생김. 앞뒤에있는 필요없는 공백들을 짤라버릴 때 
select trim(' ' from '         hello hello olleh        ')from dual;
select trim(' ' from '         hello     hello    olleh        ')from dual;

--숫자 관련 함수 
select round(1234.5678,0),round(1234.5678,1),round(1234.5678,2),
 round(1234.5678,-1), round(1234.5678, -2) from dual;
-- you must give two arguments
select round(1234.5678,1) from dual;
-- 소숫점 1자리 나옴 
-- (데이터, 소숫점 몇개까지 볼 것이냐) + 반올림도 해라 
-- -1은 1의 자리에서 반올림을 시키자, -2는 10의 자리에서 반올림을 시키자
select trunc(1234.5678,0),trunc(1234.5678,1),trunc(1234.5678,2),
 trunc(1234.5678,-1), trunc(1234.5678, -2),trunc(1234.5678, -4) from dual;

--mod(): 나눈 나머지를 계산 
select mod(7,3) from dual;
select 7/3 from dual;
select trunc(7/3,0), mod(7,3) from dual;

select ceil(3.14), floor(3.14) from dual;
-- ceil은 천장, 고로 올림, floor은 바닥, 고로 버림
-- 3.14 가 포함되어있는 숫자구간은 3과 4 사이, 그래서 ceil은 4, floor 은 3이 된다 
select ceil(-3.14), floor(-3.14) from dual;

-- 날짜 관련 함수 
-- 날짜(date)타입의 값은 SQL Developer의 환경설정에서 설정된 형식으로 출력됨
-- 도구 > 환경설정 > 데이터베이스 > NLS (National Language Support) 에서 sysdate 설정 바꿀 수 있음 
-- 날짜 데이터를 원하는 형식으로 출력하고 싶을 떄 to_char(날짜, 형식)함수를 사용 
select sysdate from dual;
select add_months(sysdate, 1)from dual;
select add_months(sysdate,10) from dual;

select sysdate + 1 from dual; 
-- add month 는 있는데, add day는 없다. 이렇게하면 더할 수 있음 :) 
select sysdate + 2 from dual;
select add_months(sysdate+2,4) from dual;
-- 알아서 그달 말일로 끝남 
-- -1 은 전날로 간다 
select sysdate -1 from dual;

select months_between(sysdate,hiredate)
from emp;
-- today - hiredate = + 

select months_between(hiredate,sysdate)
from emp;
-- hiredate - today = - 

--round 를 할 때에는 기준을 정해줘야한다 
-- 예제로 정리 
select round(sysdate, 'YYYY') from dual;
select round(sysdate, 'YYYY'), round(sysdate,'Q') from dual;
-- Q = Quarter (4분기): 1/1,4/1,7/1,10,1 
select trunc(sysdate, 'YYYY'), trunc(sysdate,'Q') from dual;
-- 무조건 짤라버리는 거니까, 전에서 가장 가까운걸로 간다 

-- 데이터 타입 변환 함수 
--to_char():문자열을 리턴
--to_number():숫자를 리턴 > 문자열을 숫자타입으로 바꿔줌 
--to_date():날짜를 리턴 > 문자열을 받아서, 그걸 날짜열로 만들어주는 
-- 우리가 원하는 함수로 출력하고 싶을 때? 

-- 오라클에서 사칙연산자 (+,-,*,/) 는 숫자 타입에서만 사용 할 수 있다 (date type은 +,- 가능) 
select '1000' + '100' from dual;
-- 컴퓨터는 '1000'을 1 0 0 0 으로 이루어진 문자로 인식한다, 100 도 마찬가지 
-- 하지만, 계산이 가능했다..! > 이런 경우 숫자로 변환 할 수 있는 문자에만 묵시적 변환이 가능하다 
-- 오라클은 숫자로 변환할 수 있는 문자열들인 경우에는 묵시적으로 타입 변환을 수행한 후 사칙 연산 계산을 함 
select '1000' + 'abc' from dual;
--FAIL. the characters cannot be calculated like numbers 
--숫자로 변환할 수 없는 문자일 경우 사칙 연산을 하면 invalid number 이라고 하는 에러를 발생시킴
select'1,000'+'100' from dual;
-- FAIL. '1,000'은 문자라고 인식하고, '100'은 숫자라고 인식되어서 계산 불가능. , 때문에 1000은 숫자로 변환이 불가하다...! 
select to_number('1,000','9,999') + to_number('100','999') 
from dual;
-- argument 가 반드시 2개가 있어야하고, ('1,000','9,999') (숫자로 변환이 되어야 될 문자, 어떻게 생겼느냐)
select to_number('12,000','9,999') + to_number('100','999') 
from dual;
-- FAIL. the function cannot convert 12,000 to a number because of the argument input we made was only up to thousands '9,999'
-- SO, we can make it function by making 9,999 to a larger number 
select to_number('12,000','99,999') + to_number('100','999') 
from dual;

-- 날짜(date)타입의 값은 SQL Developer의 환경설정에서 설정된 형식으로 출력됨
-- 도구 > 환경설정 > 데이터베이스 > NLS (National Language Support) 에서 sysdate 설정 바꿀 수 있음 
-- 날짜 데이터를 원하는 형식으로 출력하고 싶을 떄 to_char(날짜, 형식)함수를 사용 
-- 날짜>문자로 to_character 
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
--DY 는 줄임말로 표시 월요일 > 월, DAY는 complete하게 월요일로 표시 
-- RR이나 YY나 어짜피 똑같이 나타난다  

-- 설정을 영어로 바꾸었을 때, MM (01,09,이런식으로 나타남) > MON (JAN,MAR 이런식으로 나타남) 
-- 월-일-년 (미국), 일-월-년 (영국), 년-월-일(한국)
-- 세기-년-월-일-시-분-초 (시간은 7바이트) 

-- 반대로, 우리가 날짜를 데이터 베이스에 입력 할 때, 키보드로 입력하면 그건 결국 문자열> 그게 숫자로 저장이 되어야한다 
-- 문자열을 날짜로 변환해주는 함수 to_date 
-- to_date의 기본은 NLS를 따라간다 
--to_date(문자열, 날짜형식) 
select to_date ('2019/08/29') from dual; 
-- SUCCESS. 문자열이 시간에 맞게 출력이 됨 
select to_date ('19/08/29') from dual; 
-- FAIL. 4자리 인데, 그냥 19년 (A.c.19) > 되게 위험한 것 이다 
-- writing a comment related to date without knowing its setting is dangerous 
select to_date ('2019/08/29','YYYY/MM/DD'),
       to_date ('19/08/29','YY/MM/DD') 
       from dual;
-- SUCCESS. 이렇게 하면 기본 설정 상관없이 굳굳 :) 
-- YY는 현재 세기 + 뒤에 년도 두 자리 
select to_date ('2019/08/29','YYYY/MM/DD'),
       to_date ('99/08/29','YY/MM/DD') 
       from dual;
-- 이렇게 하면 ('99/08/29','YY/MM/DD') 는 2099년 8월 29일로 출력된다. YY는 현재 세기 + 뒷자리 두개! 잊지말자 
--RR 세기쓰? 1950~2049 

select to_date('50/08/29','RR/MM/DD') from dual; 
-- 현재 날짜가 2019년이라,반올림이 되는 숫자가 이것. 1800년대, 19100년대, 절대 못 들어간다 
-- 2050년에 우리가 오라클을 썼다, 그러면 그 때 2050~2149년이 100 년 단위니까 
-- 아, RR은 100년 단위로 끊어서 생각하는 거군아 
-- 문자열 뒤에 항상 포멧도 함께 기입해주는 것이 안전하다 

select to_date('05:10:15','HH:MI:SS')
from dual;

select to_date('17:10:15','HH:MI:SS')
from dual;
--FAIL. HH를 24시간으로 명시하지 않았기 때문에 에러가 난다!! 

select to_date('17:10:15','HH24:MI:SS')
from dual;

--null 값을 처리하는 함수 
-- 평균 구할 때, null은 무시하고 값이 있는 것들을 더해서 그 수 만큼 나눠준다 
-- null value 
-- nvl(변수,null을 대체할 값)/ 변수 = column 
-- nvl2 (변수, null이 아닐 때 대체할 값, null일 때 대체할 값) 

select comm,nvl(comm,0), nvl2(comm,'TRUE','FALSE') from emp;
--nvl(comm,X) FAIL 

desc emp;
-- 에서 comm은 숫자만 가능, 그래서 nvl에는 0혹은 숫자만 가능  
-- nvl2에서는 (comm,'A','B'), A와 B의 자리에 숫자끼리, 문자끼리만 가능 
-- 예) 1,FALSE, TRUE,0 이런식으론 안됨 TRUE,FALSE; O,X; comm,0 이런식으로 문자는 문자끼리, 숫자는 숫자끼리는 가능 
-- 왜냐하면 column엔 같은 타입만 들어가야하니까 
-- 묵시적 형변환이 일어날 수 있다 


