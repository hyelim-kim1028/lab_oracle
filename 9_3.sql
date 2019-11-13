-- ���ǹ� (Conditional Statement) 
-- � ���ǿ� �´� ��쿡�� �����ϴ� ������ ����� �ش�. 
-- ���ݱ����� ������ ���� �� > ������ ��� ����... > ���൵ ������� (���� �ٲ��� ����) 
-- ���� ������� ������ �� ���� �ְ�, �ȵ� ���� �ְ�, �Ʒ����� �����ߴٰ� ������ �ö󰡼� �ٽ� ���� �� ���� �ִ� ���� 

-- IF 
-- ���࿡ ~ �� �����ϸ� ������ �ϰڽ��ϴ� 
-- IF ���ǽ� then 
--    ���ǽ��� ���� �� ������ ����; 
--    end if;

-- IF statement example 1 
set serveroutput on;

declare 
    v_num number := 123;
begin 
-- if statement�� ���๮�̶� begin �� end ���̿� �� 
if mod(v_num,2) =1  then 
    dbms_output.put_line('Ȧ��');
end if;
dbms_output.put_line('END PL/SQL');

end;
/
-- �ڵ尡 ������, ���� ���� ���� ��¹��� �ٸ��� �ȴ�. �������� v_num number := 123 �ϸ� Ȧ��, END PL/SQL �� ���� ���, 124�� END PL/SQL �� ���� ��� (��) 

-- IF statement example 2 
-- Ȧ�� �� ���� Ȧ����� ���ϰ�, ¦�� �� ���� ¦����� ���ϴ� �ڵ带 ����� ����,,,! 
-- if - then - else 
/* if ���ǽ� then 
    ���ǽ��� ���� �� ������ ����; 
    else 
    ���ǽ��� ������ �� ������ ����; 
    end if; */

accept p_num prompt 'ENTER THE NUMBER';

declare 
    v_test number := &p_num;
begin 
-- if statement�� ���๮�̶� begin �� end ���̿� �� 
if mod(v_test,2) =1  then 
    dbms_output.put_line('Odd Number');
else
    dbms_output.put_line('Even Number');
end if;
    dbms_output.put_line('END PL/SQL');
end;
/

declare 
    v_score number := 68;
begin 
    if v_score >= 90 then 
    dbms_output.put_line('A');
    elsif v_score >= 80 then 
    dbms_output.put_line('B');
    elsif v_score >= 70 then 
    dbms_output.put_line('c');
    else 
    dbms_output.put_line('F');
    end if; 
end;
/ 

-- �̰� �ȵ�: 'V_GADE' �ĺ��ڰ� ���ǵǾ�� �մϴ�/ PL/SQL: Statement ignored (line 71) 
-- �̰� �ȵ�: �� �ȵǴ��� �𸣰��� (line 31 had a wrong spelling > learn to do it yourself,,,) 
-- the line said: 'V_GADE' �ĺ��ڰ� ���ǵǾ�� �մϴ� > but it said ����� 75 �࿡�� �����ϴ� �� ���� �߻� -
-- what I thought: I cannot find anything wrong from line 24 (because it says which block is wrong not which line) 
-- what I could have done > since there are only few sentences which has 'V_GADE'; I could have checked those lines

accept p_grade prompt 'ENTER THE GRADE';

declare 
   v_grade number := &p_grade;
begin 
if v_grade >= 90 then 
    dbms_output.put_line('Congratulations! '||'Your hardwork deserves an '||'A');
elsif v_grade >= 80 then 
    dbms_output.put_line('Congratulations! '||'Your GRADE is '||'B');
elsif v_gade >= 70 then 
    dbms_output.put_line('You should put more effort! '||'Your GRADE is '||'C');
else
    dbms_output.put_line('You failed the subject :('||'Your GRADE is '||'F');
end if; 
    dbms_output.put_line('Enjoy your vacation!');
end;
/

-- The correct one: 
accept p_grade prompt 'ENTER THE GRADE';

declare 
   v_grade number := &p_grade;
begin 
if v_grade >= 90 then 
    dbms_output.put_line('Congratulations! '||'Your hardwork deserves an '||'A');
elsif v_grade >= 80 then 
    dbms_output.put_line('Congratulations! '||'Your GRADE is '||'B');
elsif v_grade >= 70 then 
    dbms_output.put_line('You should put more effort! '||'Your GRADE is '||'C');
else
    dbms_output.put_line('You failed the subject:( '||'Your GRADE is '||'F');
end if; 
    dbms_output.put_line('Enjoy your vacation!');
end;
/
-- �����Ʈ: line 82/ gade > grade 




-- �Է¹��� ���ڰ� ¦������ Ȧ������ ���� 
--1) if the number is a even number, print it as 'even number' 
-------- If it is an even number and a multiplier of 4, print it as 'MULTIPLIER OF 4' 
--------- If not, print it as 'NO, it is not' 
--2) if the number is an odd one, print it as 'odd number' 

accept p_number prompt 'ENTER THE NUMBER'; 

declare 
    v_number number := &p_number;
begin 
    if mod(v_number, 2)=0 then 
        dbms_output.put_line('EVEN NUMBER');  
        if mod(v_number, 4)=0 then 
            dbms_output.put_line('MULTIPLIER OF 4'); 
        else 
            dbms_output.put_line('NOT A MULTIPLIER OF 4');
        end if;
    else
        dbms_output.put_line('ODD NUMBER'); 
    end if;  
end;
/

select power(5,2) from dual;

-- Pythagoras Theorem (a^2 + b^2 = c^2) 
-- ���� 3�� �Է� (3������ 3���� ����) 
-- ��Ÿ��� ������ �̿��ؼ� �ﰢ���� ���� �ﰢ������ �ƴ����� ����ϼ��� 
-- �̰͵� �ȵ�,,^^ 
accept linea_A prompt 'Entre la linea A';
accept linea_B prompt 'Entre la linea B';
accept linea_C prompt 'Entre la linea C'; 

declare 
    v_A number := &linea_A;
    v_B number := &linea_B;
    v_C number := &linea_C;
begin 
If power(v_A,2) + power(v_B,2) = power(v_C,2) then 
    dbms_output.put_line('RIGHT TRIANGLE');
    else 
    dbms_output.put_line('NOT A RIGHT TRINGALE);
end if;
end;
/

-- ����: ������ ������ �Ǽ� �׷��� (�巡���ؼ� �� �κи� ��� �����ϴϱ� ������ �Ǿ���) 

accept a prompt '�ﰢ�� �غ��� ����?';
accept b prompt '�ﰢ�� ����?';
accept c prompt '�ﰢ�� ������ ����?';

begin 
    if power(&a,2) + power(&b,2) = power(&c,2) then 
        dbms_output.put_line('�����ﰢ��');
    else 
        dbms_output.put_line('Not �����ﰢ��');
    end if; 
end;
/