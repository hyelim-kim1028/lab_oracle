--20190909 14.1 EXERCISE 1 - LOOP/CONDITIONAL 

set serveroutput on;

-- ������ ����ϴ� ��� 
begin 
    dbms_output.put_line('hello'); 
    dbms_output.put_line('world'); 
    -- �� ���, ȭ�鿡�� ����, ���� ����� �ȴ�. 
    dbms_output.put('Tiger');
    dbms_output.put(' is a cat');
    -- ���� �ΰ��� ����� ������, �̰� ���� �ʴ�; output ���� �� ������ ������ ���Ͱ� ��� ȭ�鿡 ��µ��� ���� 
    dbms_output.new_line;
    -- ����� �ȴ� : ������ �ȴ� (�� �ٲޱ�ȣ�� ����� ����̵ȴ�) 
end;
/

--ȭ�鿡 ***** ��� 
begin 
    dbms_output.put_line('*****');
end;
/

begin 
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.put('*');
    dbms_output.new_line;
end;
/

begin 
    for i in 1..5 loop 
    dbms_output.put('*');
    end loop;
    dbms_output.new_line;
end;
/

begin 
    dbms_output.put_line('*');
    dbms_output.put_line('**');
     dbms_output.put_line('***');
    dbms_output.put_line('****');
    dbms_output.put_line('******');
    
end;
/

--�Ʒ��� ���� ����ϴ� PL/SQL �� �ۼ��Ͻÿ� 
/* *
   **
   ***
   ****
   ***** */
   
begin 
    for dan in 1..5 loop 
        dbms_output.put('*');
        for i in 1..5 loop 
            dbms_output.put('*');
        end loop; 
    end loop;
    dbms_output.new_line;
end;
/
-- ��) ���� �õ��� �� ��: Ʋ�� 
-- ***** �� ¥���� 5�� �ݺ��صаŶ�� �����غ��� 

begin 
    for i in 1..5 loop 
    dbms_output.put_line('*****');
    end loop;
end;
/

-- �׸���,, 

begin 
    for i in 1..5 loop 
        for j in 1..5 loop
            dbms_output.put('*');
            exit when i = j; 
        end loop;
        dbms_output.new_line;
    end loop;
end;
/
-- �׷� ����� �Ȱ��� ����� �����´� > ���� ������ ���δ� exit when i = j; 
-- ���� ������ ���������Եȴ� (�ٱ��� ������ �ٽ� �����ϱ�,,?) �������� 


begin 
    for i in 1..5 loop 
        for j in 1..i loop
            dbms_output.put('*'); 
        end loop;
        dbms_output.new_line;
    end loop;
end;
/
-- exit�� �� �� �� 


-- using the while clause 
declare 
    n number 
begin 

end;
/ 



--�Ʒ��� ���� ����ϴ� PL/SQL �� �ۼ��Ͻÿ� 
-- reverse loop 
begin 
    for i in 1..5 loop -- �̰� ���ȣ�� �ȹٲ� 
        for j in reverse 1..5 loop
            dbms_output.put('*');
            exit when i = j; 
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

-- or 
-- reverse �Ⱦ��� �ϴ� ��!
begin 
    for i in 1..5 loop -- �̰� ���ȣ�� �ȹٲ� 
        for j in i..5 loop
            dbms_output.put('*');
        end loop;
        dbms_output.new_line;
    end loop;
end;
/

/*-- ������ ���� ����ϴ� ������ ������ 
12345678910
11 12 13 14 ... 20 
21 22 23 24 25 ... 30 
...
91 92 93 94 ... 100
*/

-- �� ���� ������� 
begin 
    for i in 1..10 loop 
         for j in 1..i loop 
            dbms_output.put(number);
        end loop; 
    end loop; 
    dbms_output.new_line; 
end loop;
end;
/

declare 
    n number; 
begin 
for in 1..10 loop 
    loop n = n + 1;
    dbms_output.put(n) 
    end loop; 
    dbms_output.new_line;
end loop; 
end;
/

-- ���� 
declare 
    n number := 1;
    i number := 1; 
begin 
loop 
    n := 1; 
    for i in 1..9 loop 
     dbms_output.put_line((10 * n ) - i); 
    end loop; 
    
end loop; 
end;
/


/* 

*
**
***
****

*/

declare 
 i number; 
 j number;
begin 
    i := 1; 
    loop 
       j := 1;
    loop 
        dbms_output.put('*');   
    j := j+1;
    exit when j>i;
    end loop;
    dbms_output.new_line();
    
    i := i+1; 
    exit when i=5;
    end loop;
end;
/


