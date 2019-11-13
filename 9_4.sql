/* Case ~ when ���� 
(1)
case �񱳴�� 
when ��1
then �񱳴�� = �� ��1 �� ������ �� ������ ����; 
... 
else �񱳴���� ���� ��� ���� ��ġ���� ���� �� ������ ����;  
end case; 
-- ���� �ٸ����� ���� 

(2) -- IF ���?�Ȱ�? 
case
when ���ǽ�1 then 
 ���ǽ�1�� ���� �� ������ ����; 
when ���ǽ�2 then 
 ���ǽ�2�� ���� �� ������ ����;  
 ...
 else ���� ��� ������ ������ �� ������ ���� 
 end case; 
-- ũ�� �۴ٵ� ���� ���� 
*/


-- (1) sample 
set serveroutput on;

accept p_grade prompt 'ENTER THE GRADE';

declare 
    v_score number := &p_grade;
begin 
    case trunc(v_score,-1)
    -- original thought: case trunc(v_score/10,0) > but here, it should be when 10 then ~ when 9 then ~ when 8 then~ 
        when 100 then 
        dbms_output.put_line('A');
        when 90 then 
        dbms_output.put_line('A');
        when 80 then 
        dbms_output.put_line('B');
        when 70 then 
        dbms_output.put_line('C');
        else 
        dbms_output.put_line('F');
    end case;

end;
/


-- (2) sample 
accept p_grade prompt 'Enter the Grade';

declare
    v_score number := &p_grade; 
begin
    case 
    when v_score >= 90 then
        dbms_output.put_line('A'); 
    when v_score >= 80 then 
        dbms_output.put_line('B');
    when v_score >= 70 then 
         dbms_output.put_line('C'); 
    else 
        dbms_output.put_line('F');
    end case; 
end;
/
    

