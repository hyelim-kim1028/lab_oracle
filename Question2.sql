--2. 
--다음과 같은 수열을 피보나치 수열(Fibonacci numbers)라고 합니다.
--1, 1, 2, 3, 5, 8, 13, 21, 34, ...
--피보나치 수열은 다음과 같은 식으로 일반화할 수 있습니다.
--f[1] = 1, f[2] = 1, 
--f[n] = f[n-1] + f[n-2], n >= 3
--피보나치 수열의 원소 20개를 출력하는 PL/SQL을 작성하세요.
--이웃하는 피보나치 수의 비율은 황금비(golden ratio)라 불리는 수 1.61803...에 수렴함을 보이세요.
--f[n+1] / f[n] ~ 1.61803...

set serveroutput on;

declare 
    num1 number := 1; 
    num2 number := 1;
    num3 number; 
begin 
    dbms_output.put_line(num1); 
    dbms_output.put_line(num2); 
    
   for i in 3..20 loop 
    num3 := num1 + num2; 
        num1 := num2; 
        num2 := num3; 
    dbms_output.put_line(num3); 
    end loop; 
end; 
/ 

-- 이 숫자들을 저장해서 해보면 어떨까 
--이웃하는 피보나치 수의 비율은 황금비(golden ratio)라 불리는 수 1.61803...에 수렴함을 보이세요.
--f[n+1] / f[n] ~ 1.61803...

--계획: 
-- 위에 숫자들을 컬렉션 저장 또는 function으로 만들어서 
-- 저기 위에서 가져온 숫자들을 가지고 f[n+1] / f[n] ~ 1.61803...

