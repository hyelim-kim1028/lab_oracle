-- 09092019 HOMEWORK RESULTS 
-- TEACHER'S SOLUTION 
set serveroutput on;
-- 1. Multiplication from 2~9 
-- A. LOOP

declare 
    v_dan number := 2; 
    v_x number := 1;
begin 
    loop
    v_x := 1; 
        loop 
            dbms_output.put_line(v_dan||' X '||v_x||' = '||(v_dan*v_x)); 
            v_x := v_x +1; 
            exit when v_x = 10; 
       end loop; 
       dbms_output.put_line('-------------------');
      v_dan := v_dan+1; 
        exit when v_dan = 10; 
    end loop; 
end;
/

-- 1. 3��, 4��, 5��... �ݺ� �� �� �ִ� 
-- �� ��, n * x �� n�� �ڸ��� �ݺ� > �̷��� �Ϸ��� loop �� loop��Ű�� �ȴ� loop(loop()) 
-- without v_x := 1 on the first loop, it does not work because of v_dan
  -- �Ʒ��� ������ ������ ��� 10���� �ؼ� �Ʒ��� ������ ���� �ݺ��� �Ǵ°���! 1���� �����ϱ� ���ؼ��� ��������! 1���� �������ڰ� 
     --  sin esta frase, no se funciona porq desde de loop dentro> ha hecho 2*1 ... 2*9. Entonces, que hace es empieza del v_x =10.
     -- es la razon que no funciona. Para empieze del 1 en v_dan, tener que indicar que v_x := 1

--B. WHILE LOOP 
declare 
    dan number; 
    n number;
begin 
    dan := 2; 
    while dan < 10 loop 
        dbms_output.put_line(dan||'��');
                -- �ش� �� (2��, 3��,..9��) ��� 
            n := 1;
            while n<10 loop
            dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
            n := n+1; 
            end loop;
        dbms_output.put_line('--------------');
        dan := dan + 1; 
    end loop; 
end;
/

--C. FOR LOOP 
 
begin 
 for dan in 2..9 loop
 dbms_output.put_line(dan||'��'); 
    for n in 1..9 loop 
    dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
    end loop; 
 dbms_output.put_line ('--------------------');
 end loop; 
end;
/

-- ��� ����ص� �ȴ�!! :) 
-- �������� �����غ��� :) 


--2.
-- ������ (2~9��)�� ��� 
-- 2���� 2*2 ����, 3���� 3*3 ����,,, 
-- basic loop + while loop �� �� ����ؼ� ������ �غ��� :-) 

-- for loop 

begin
    for dan in 2..9 loop
    dbms_output.put_line(dan||'��');
    
        for n in 1..9 loop 
        dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
        exit when dan = n;
        -- �ڱⰡ ���ԵǾ� �ִ� ������ ��������. �� ���������� �ٽ� ���� 
        end loop; 
        
         dbms_output.put_line ('--------------------');
    end loop; 
end;
/


-- exit�� ������� �ʰ� �ϴ� ��� 
begin
    for dan in 2..9 loop
    dbms_output.put_line(dan||'��');
    
        for n in 1..dan loop 
        dbms_output.put_line(dan||' X '||n||' = '||(dan*n));
        end loop; 
        
         dbms_output.put_line ('--------------------');
    end loop; 
end;
/

--3. �������� ���� �������� �ո�� �޸��� ���� Ȯ���� 1/2���� �����ϼ��� 
--(1) dbms_random.value(x,y)�Լ��� ����ؼ� 0 �Ǵ� 1�� �������� ����ϴ� 
-- x <= r < y 

select dbms_random.value(0,1) from dual;
-- 0 ���� 0.999999 �� ���ڸ� ���� 
select dbms_random.value(0,2) from dual;
-- 0 ���� 1.9999999 �� ���ڸ� �ش� 
-- ���⼭ �Ҽ����� ��� �߶��ָ�, 0 Ȥ�� 1�� ���� ������ �ȴ� (r = 0 or 1) => trunc 

--(2) (1) ���� �ۼ��� �ڵ带 �����ؼ� 
select trunc(dbms_random.value(0,2),0) from dual;
-- (2) (1)���� �ۼ��� �ڵ带 �����ؼ�, 
-- ������ 0�̸� '���� �ո�(head)', 1�̸� '���� �޸�(tail)'�̶�� ����ϴ� PL/SQL�� �ۼ��ϼ���.(if statement, 0= head, 1=tail)

declare 
    v_coin number; -- 0 �Ǵ� 1(������ ��/�޸�)�� ������ ���� 
    v_head number := 0; -- if statement �� ������ -- (v_coin = 0�� ��, ī��Ʈ�� 1�� ������ų ����) 
    v_tail number := 0; --(v_coin = 1�� ��, ī��Ʈ�� 1�� ������ų ����) -- ��𼭺��� 1�� ������ų ���ΰ��� ���� �ʱⰪ�� �ʿ��ϴ� 
    v_trials constant number := 1000
    ; -- ����(�ݺ�)Ƚ�� (������ �̷����ϸ� �ٲ� �� ���� ����) > 1000 �� �ִ� �� ��θ� ����������...!> 
                                     -- before: ����Ƚ���� �ٲٱ� ���ؼ��� 3���� ���� ����> ����: 1�� 
                                     -- ������ �ҽ��ڵ带 ���� ������ �� �ֵ��� �϶�...!! (������ �����ϸ� ���߿� �ڵ带 ����, ���� �ϱ� ����) 
    
begin 
for i in 1..v_trials loop
    v_coin := trunc(dbms_random.value(0,2),0); 
   --dbms_output.put_line(v_coin);
    if v_coin = 0 then 
      v_head := v_head + 1;
     --   dbms_output.put_line(HEAD);
    else 
    v_tail := v_tail +1;
      --  dbms_output.put_line(TAIL);
    end if; 
end loop;   
dbms_output.put_line('�ո�: '||v_head||'Ȯ��: '||(v_head/v_trials));
dbms_output.put_line('�޸�: '||v_tail||'Ȯ��: '||(v_tail/v_trials));
end; 
/
-- for loop  �� �Ἥ 1000�� �ݺ� 
-- (3) 0 �Ǵ� 1�� �����ϰ� ����� ����((1) �ڵ�)�� 1000�� �ݺ��ؼ�, 0�� 1�� �߻� Ƚ���� �����ϰ�,
-- 0�� ���� Ƚ�� / ��ü Ƚ��, 1�� ���� Ƚ�� / ��ü Ƚ�� �� ���
-- Ƚ��/1000 > 0.5,0.5, 0.510,0.487 ... 
-- ������ 1000 �� �ߴ�...!! ������ Ƚ���� �ٸ����ϸ� > for loop ��, Ȯ�� �� ... �ٲ���Ѵ� 


--4. ����ī���� �˰����� �̿��� pi�� �ٻ簪(3.141592...) ���
-- (1) dbms_random.value() �Լ��� ����ؼ�, 2���� ��ǥ���(x-y) ���� ���� ��ǥ (x, y)�� �������� ����.
-- ��, 0 <= x < 1, 0 <= y < 1
-- (2) sqrt(x ** 2 + y ** 2 )< 1�� �����ϸ� v_hit ������ ���� 1 ���� -- 1)���� ������� x,y�� ���� ������ �Ÿ������ �ؼ�, ... 
--> x^2 + y^2 < 1
-- (3) (1), (2)�� ������ 1000�� �ݺ�
-- (3) (v_hit / 1000) * 4�� ����� ���� ���

declare 
    x number; -- x��ǥ�� ���� ������ ���� 
    y number; -- y��ǥ�� ���� ������ ���� 
    hit number := 0; -- ���������� �Ÿ��� 1 �̸��� ��� 1�� ������ų ���� 
    trials constant number := 1000;
   pi number;
begin 
for i in 1..trials loop 
    x := dbms_random.value(0,1);
    y := dbms_random.value(0,1); 
    dbms_output.put_line(x||','||y);
   -- ��ǥ���� ���� ���� ���̴�~ 
    if sqrt(x**2 + y**2) < 1 then 
        hit := hit + 1; 
    end if; 
end loop;  
    dbms_output.put_line('hit = '||hit); -- ��� 800�� ����
    pi := (hit/trials)* 4;
    dbms_output.put_line('pi = '||pi);
end;
/ 
-- 3.14�� ����� ���� ���´� 
