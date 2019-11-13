/* 컬랙션(collection): 컬랙션은 같은 타입의 데이터 여러개를 저장할 때 사용 

1)연관 배열 (associative array, index by table) 
- associates a unique key with a value. 
- An associative array type must be defined before array variables of that array type can be declared. 
- Data manipulation occurs in the array variable.
- key/index와 value의 쌍으로 구성되는 컬렉션 
- 연관 배열에서 key/index는 binary_integer(정수), pls_integer(양의 정수), varchar2 (문자열)타입이 가능 
-- PLS_INTEGER (plus integer) is defined in the STANDARD package as a subtype (or rather a synonym) of BINARY_INTEGER.

- 연관배열을 선언(정의)하는 방법 
----- type 배열이름 is table of 데이터타입 index by 인덱스타입; 
- index by binary_integer(정수), pls_integer(양의 정수), varchar2 (문자열)타입이 가능 (3中1) 
- 데이터타입: 우리가 만든 레코드, 날짜, 시간, 숫자, 문자... 다 올 수 있다 



2)중첩 테이블 (nested table)
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

--A.연관배열 
declare 
    -- 문자열을 원소로 갖고, 양의 정수를 인덱스로 사용하는 연관배열을 정의하자 
    -- 배열의 이름 정의 
    type students is table of varchar2(20) index by pls_integer; 
    
    --정의한 연관 배열 타입의 변수 선언 (배열이름 배열파일;) 
    v_stu students; 
    
begin
    -- 연관 배열에 데이터 저장: 배열이름(v_stu)(인덱스) := 값; 
    v_stu(1) := '강다혜'; 
    v_stu(2) := '김수인';
    v_stu(3) := '김영광';
    
    -- 연관 배열에 저장된 원소(데이터)의 값을 읽을 때: 배열이름 (인덱스) 
    --dbms_output.put_line(v_stu(1)); 
    -- v_stu에 값들을 저장했고, 배열(1)에 저장된 값을 보여준다 
    -- 인덱스를 보통을 숫자로 하는 이유: 1씩 증가하는 숫자들은 for loop 반복문을 할 수 있기 때문에 
    -- 인덱스는 절대로 겹쳐서는 안되요!!!!!!!!!!!! 
    -- 예) 
    for i in 1..3 loop
    dbms_output.put_line(v_stu(i)); 
    end loop; 
end;
/

declare 
-- 인덱스 타입: varchar2(20),원소의 타입:number인 연관 배열을 정의(선언) 
type cellphone is table of number index by varchar2(20); 

-- 연관배열 타입의 변수를 선언 
celln cellphone; 
begin 
-- 연관배열의 데이터를 3개 저장 
celln('Spain') := 34;
celln('Korea') := 82; 
celln('Phil') := 63; 
-- 연관배열에 저장된 데이터를 출력 
-- 인덱스는 겹치면 안되지만, 값은 겹쳐도 된다 (메뉴라면 짜장면, 짬뽕 - 인덱스, 다 다름, 하지만 값이 둘 다 4500 이라도 no hay problema) 

dbms_output.put_line(celln('Spain'));
dbms_output.put_line(celln('Korea'));
dbms_output.put_line(celln('Phil'));

end;
/

-- 생각을 하자 ㅠㅠㅠㅜㅜ 제발,,, 
declare 
    -- index 양의 정수 데이터 타입 숫자 인 연관 배열(arr_number)을 선언 
type arr_numbers is table of number index by pls_integer; 

    -- 연관배열 타입의 변수(v_scores)를 선언 
v_scores arr_numbers; 
v_sum number; -- 점수들의 합계를 저장할 변수 
v_avg number; -- 점수들의 평균을 저장할 변수 
-- 이 아이들이 선언되어 있지 않아서 안되는 거였어,,,, OMG 
-- 이 데이터 아가들은 어떤 테이블에 있는게 아니라 함수 sum(), avg() 를 쓰지 못하는 거였다...! 
begin 
-- 연관 배열 v_scores 5개의 정수 (0~100)를 입력 
v_scores(1) := 90;
v_scores(2) := 88;
v_scores(3) := 91;
v_scores(4) := 89;
v_scores(5) := 92;

-- v_scores.count 면 이 아이들의 갯수를 세어주는 아이! 

-- for i in 1..5 loop
    --dbms_output.put_line(v_scores(i)); 
    --end loop;
    

--5개의 정수 합계를 계산해서 출력 
--select sum(v_scores) 
--into arr_numbers
--from dual;

--v_sum := v_scores(1) + v_scores(2) + v_scores(3) + v_scores(4) + v_scores(5);
-- 함수를 사용하는게 아니라 변수에 계산해서>출력 

--dbms_output.put_line('sum = '||v_sum);

-- 배열로 선언되어진 변수가 코드에서 사용되어진다 (그 값이 아니라) v_scores(1) not 90 
-- 10개 라면? 숫자가 많아진다면? -- for loop 사용 
-- sum := 0; 으로 초기화 

v_sum := 0;
for i in 1..v_scores.count loop
    v_sum := v_sum + v_scores(i); 
    end loop;
    dbms_output.put_line(v_sum);

-- 5개의 정수의 평균을 계산해서 출력 
--select avg(v_scores) 
--into arr_numbers
--from ; 

--v_avg := v_sum/5;
--dbms_output.put_line('average = '||v_avg);

v_avg := v_sum / v_scores.count;
dbms_output.put_line(v_avg);
end;
/

-- 데이터가 n개 있다,,, x1,x2,x3 ...xn 
-- 평균: x1+x2+x3 ... +xn /n ...분산...표준편차 

select sum(sal),avg(sal),variance(sal),stddev(sal) from emp;
-- PL/SQL 에서는 select into from 을 사용해서 위의 함수 사용 
-- emp 테이블에서 급여의 총합, 평균, 분산, 표준 편차를 출력하는 PL/SQL 을 만들고 싶다!

--테이블에 들어있는 아이들일 경우: utilize the functions  already existing in the system 
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
-- 배열 변수 이름.count: 배열의 원소의 개수 (예.v_scores.count) 
-- 배열 변수 이름.first: 배열의 첫번째 인덱스 (예.v_scores.first) 
-- 배열 변수 이름.last: 배열의 마지막 인덱스 (예.v_scores.last) 


-- 인덱스에는 양의 정수, 배열의 원소(데이터)는 숫자 타입인 연관 배열을 정의하세요 
-- 난수함수와 (dbms_random.value(x,y))  trunc 함수를 이용해서 연관배열에 
-- for loop을 사용해서 연관배열에 10의 시험 성적 0~100점사이 성적을 저장 
-- 10개의 시험 성적에 총합, 평균, 분산, 표준편차,최댓값,최솟값을 계산하는 식을 구현 
-- root > sqrt(); power(x,y), sqrt(x)
-- 테이블에 10개의 시험 성적을 insert 
-- 계산한 결과와 sql을 이용한 결과가 같은 지 비교 

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
-- 101인 이유: 0,100 > 0부터 99.999999 ... 그래서 101 > 100 점까지 포함해주기위해서 

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
-- 왜 에러나 ㅠㅠㅠㅜㅜㅜ 어으어아ㅓㅁ;ㅑㄹㄷ러ㅣㅏ어랻


-- ex_scores 테이블에 생성된 점수들을 insert 
delete from ex_scores; --테이블에 데이터가 있다면 전부 삭제 

for i in 1..v_grades.count loop 
 insert into ex_scores values (i,v_grades(i));
   end loop; 
    commit;   
-- 이제 테이블에 데이터가 있으니까 함수들로 값들을 불러올 수 있음 

-- 시험 성적들의 기술통계량 (descriptive statistics) 변수들
select sum(score),avg(score),trunc(variance(score),2),trunc(stddev(score),2),max(score),min(score) 
into v_sum, v_avg,v_var,v_std,v_max,v_min 
from ex_scores;

-- into 아가들 v_sum, v_avg,v_var,v_std,v_max,v_min 가지고 record를 만들고 > 그걸 constant 로 써도 괜찮음 

-- 시험 성적들의 기술통계량 (descriptive statistics) 확인 
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


 