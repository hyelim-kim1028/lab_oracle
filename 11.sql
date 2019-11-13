-- 09.17.2019 MARTES 
-- ex32 in teacher's file 

/*
�÷��� - ���� Ÿ���� ������ �������� ���� 
* 3���� �÷��� - 3���� �÷����� ���� Ư¡���� ���� �ִ�  
1) ���� �迭 (associative array or index-by table) 
    > �ε����� ����, ���� ����, ���ڿ��� ����� �� ����. 
    > type ���� �迭 �̸� is table of ������ Ÿ�� index by �ε��� Ÿ��; 
    > ������ �� �ִ� ������ ������ ������ ���� 
    > ������ ��� ���� 
    
2) ��ø���̺�(nested table) 
    > �ε����� ���� ������ �����ϱ� ������ �ε��� Ÿ��(index-by)�� ������� ���� 
    > type ��ø���̺� �̸� is table of ������ Ÿ�� ; 
    > ������ �� �ִ� ������ ������ ������ ���� 
    > ������ �ݵ�� ��� 
    
3) varray 
    > ���� ���� �迭 (variable-size array) 
    > �ε����� ���� ������ �����ϱ� ������ �ε��� Ÿ��(index-by)�� ������� ����  
    > type ���̺��̸� is varray(limit) of ...(i.e. number,varchar2,date); 
    > varray�� ������ �� ������ �� �ִ� ���� ����/������ ������ (������ �� �ִ� ������ ������ ����) 
    > ������ �ݵ�� ��� 
    

-- �����ڶ� �����ΰ�! 

*/


set serveroutput on;

declare 
    -- ��ø ���̺� ���� 
    type NumberArray is table of number; 
    -- number�� ���� ���� > �׷��� varray�� �ٸ��� ���Ѵ�� Ȯ�� ���� 
    -- ��ø ���̺� Ÿ���� ���� ���� 
    v_numbers NumberArray;    
begin 
    v_numbers(1) := 100;
end;
/
-- ERROR: "Reference to uninitialized collection"
-- ��ø ���̺��� �ݵ�� �����ڸ� ȣ���ؼ� �ʱ�ȭ(initialize)�� �ؾ��� 
-- �ʱ�ȭ: �ּҿ� � �Ϳ� ���� �ִ� �� 

set serveroutput on;

declare 
    -- ��ø ���̺� ���� 
    type NumberArray is table of number; 
    -- ��ø ���̺� Ÿ���� ���� ���� 
     v_numbers NumberArray;
begin 
  -- NewArray is the ������ here / �������� �̸��� Ÿ���� �̸��� ���� 
    -- ��ȣ ���� ���� (�Ű�����) > �������� �Ű������� ��ø ���̺�/ varray �� ������ ������ ������ (���,,,@@??) 
    -- �迭�� ����� �ִ� ��> ������ 
    -- �ȿ� �迭�� ������ ������ �־��ش� (�Ű�����) 
 v_numbers := NumberArray(100,200,300); 
    
    -- ��ø ���̺� ����� ������ ��� 
    for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
        end loop;
        
        -- ��ø ���̺� ���� �߰� 
        -- extend(����)�� ȣ���ؼ� �迭�� ������ �� �ִ� ������ ������ �÷��� �� 
        -- ���� �߰��ؾ� ��. 
        v_numbers.extend(2);
        -- 2�� ������ ������ �ִ� ������ 2���� �߰� (��: 3�� > ��ȭ ��: 5��) 
        v_numbers(4) := 400;
        v_numbers(5) := 500;
        -- ERROR: subscript beyond count 
        -- �迭�� ������ �ִ� ������ ���� > count > 4���� �ȵ� 
        -- �Լ�(extend)�� ���� ���� (������ �þ�� ����!) 
        
         for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
        end loop;
end;
/

-- varray 

declare 
    -- ���� ����� ���� �ٸ��� 
    -- varray Ÿ�� ���� 
    type NumberArray is varray(5) of number;    
    -- varray Ÿ���� ������ ���� 
    v_numbers NumberArray; 
begin 
    v_numbers(1) := 11; 
end;
/
-- varray Ÿ���� �̷��� �����ϸ� > �����߻� (������ ȣ���� �ؾ���) (ERROR:  "Reference to uninitialized collection")


declare 
    -- ���� ����� ���� �ٸ��� 
    -- varray Ÿ�� ���� 
    type NumberArray is varray(5) of number;    
    -- varray Ÿ���� ������ ���� 
    v_numbers NumberArray; 
begin 
    --v_numbers(1) := 11; 
    -- ������ ȣ�� ���� varray�� ����� ���� ����. 
    
    v_numbers := NumberArray(11,22,33); 
    dbms_output.put_line('count: '||v_numbers.count);
    dbms_output.put_line('limit: '||v_numbers.limit);
    -- limit�� ������ ��Ʈ�Ͽ� �ִ� 
    
    for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
    end loop;
    
    -- v_numbers(4) := 44; 
    -- ERROR: subscript beyound count 
    -- ������ �� �̹�  5�� ������, ���� ���� ���� 
    -- varray�� ���Ҹ� �߰��ϰ� �ʹٸ�, extend�� ����ؼ� ���� �߰� 
     v_numbers.extend(2);
     v_numbers(4) := 44;
     v_numbers(5) := 55; 
     
     for i in 1..v_numbers.count loop 
        dbms_output.put_line(i||' : '||v_numbers(i));
    end loop;
    
     dbms_output.put_line('count: '||v_numbers.count);
    dbms_output.put_line('limit: '||v_numbers.limit);
    
    --v_numbers.extend(5);
    -- ERROR: substript outside of limit 
    -- 5�̻� extend �� �� 
end;
/

-- �������� 
-- ���ڿ� 5���� ������ �� �ִ� varray�� StringArray��� �̸����� ���� 
-- StringArray Ÿ���� ����(v_names)�� ���� 
-- ����κ� �ȿ��� v_names �� ���Ұ� ���� varray�� �ʱ�ȭ (������ ȣ��) 
-- v_names�� �����ϴ� ���� 5���� ���� 5���� Ȯ�� (extend) �� �Ŀ� ���ϴ� ������ ���� 

declare 
    type StringArray is varray(5) of varchar2(20); 
    
    v_names StringArray; 
begin 
    v_names := StringArray(); 
    -- �ڿ� () ���ϸ� ������ 
    
    dbms_output.put_line('count: '||v_names.count);
    dbms_output.put_line('limit: '||v_names.limit);
    
   v_names.extend(5);

    v_names(1) := 'Helena';
    v_names(2) := 'Hellena';
    v_names(3) := 'Elena';
    v_names(4) := 'Herena';
    v_names(5) := 'Herrena';
    
    for i in 1..v_names.count loop 
        dbms_output.put_line(i||' : '||v_names(i));
    end loop;
    
end;
/ 

-- ��κ� �����迭�� ������ ���� �� �ִ� 



