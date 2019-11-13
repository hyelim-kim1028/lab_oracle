--PL/SQL (Procedural Language Extension to SQL )
-- SQL�� ���� ������ ��� Ȯ�� ��� 
-- PL/SQL �� �ʿ伺 
-- EX.����(emp)���̺��� �μ��� �������� ������ ����ϰ�ʹ� 
select * from emp where deptno = ?; 
-- �μ���ȣ�� �𸣴ϱ� �μ����̺��� �μ���ȣ�� ������;��Ѵ� 
-- � �μ���ȣ���� �ִ����� Ȯ���ϱ� ���ؼ� dept���̺��� Ȯ�� 
select deptno from dept;
-- �˾Ƴ� �μ� ��ȣ�� ������ select���� �μ� ������ŭ ���� 
select * from emp where deptno = 10;
select * from emp where deptno = 20;
select * from emp where deptno = 30;
select * from emp where deptno = 40;
-- �̰� ��� �� ���� (procedure)�� ���� ��, ������ �ݺ��� ���� > ��ȿ���� 
-- �ϳ��� ������ �ϼ��ϱ� ���ؼ� �۾��� ���������� �����ؾ� �� �ʿ䰡 �ִ� 

/*PL/SQL�� ����� ���� ���� 
declare �����ϴ�, ���û��� 
    ����� �����ϱ� ���� ������ ����; (i.e. deptno from the above)  
begin   �����ϴ�, �����, �ʼ�����   
    ���๮ �ۼ�; (insert, select..) 
exception ����/����, ����ó��, ���û��� 
    ����ó����; (�����ϴٰ� ���� ���ܵ�) 
end; ���� 

0(���ǻ���). delare, begin, exception ���� �����ݷ�(;)�� ������� ����, end���� ��� 
0. end�� �� ����� (����������, ���๮, ����ó����,...) ������ semi colon��� (�ݵ��������)
0. PL/SQL ��� ���� ������ �������� �ּ��� �� ����� �� ����.
0. sqlplus ���â������ PL/SQL ����� �������� ����ϱ� ���ؼ� 
end; ���� �ٿ� ������(/)�� �� ��� ��. 
*/
-- BEGIN & END �� �ٸ��� ��� �� �־����!!!!!!!!! 

set serveroutput on;
declare 
    v_num number := 999; 
begin 
    dbms_output.put_line('v_num �� ='|| v_num);
end; 
-- PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�. - ������� �������� �ʴ´� (b4: sin set serveroutput on;) 
-- despues: v_num �� =123>PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
-- || = �̾��ְڴ�, ���ڿ��� ���ڿ�/���ڿ��� �̾ ������ְڴ� 
-- ������ �ϳ��� ����/���� ���ν������ �θ��� 

-- cmd ������ end;/ �ؾ� ����ȴ� '/' �߿��մϵ�ƾƾƾ� 
-- '/'�� ������ ���� �ƴ϶� �Ʒ����ٰ� ���ּ��� 


declare 
    /*
    ���� ���� �κ� (�̷��� �ּ� ����� �� �� �ִ�) 
    �� �̸��� block �ּ� 
    */
    v_num number := 999; 
begin 
    -- �� �̸��� �� ���� �ּ� 
    -- ȭ�� (�ܼ�) ��� 
    dbms_output.put_line('v_num �� ='|| v_num);
    -- �̷��� 
    -- �䷸�� �ּ���� ���� 
end; 
/

/* PL/SQL ����
����(variable)�̶�? ���α׷�(���ν���)���� ���Ǵ� �����͸� �����ϴ� ���� 
PL/SQL���� ������ declare��� �ȿ��� �Ʒ��� ���� �������� ����/�ʱ�ȭ�� �� 
(declare, begin, exeption,end �߿��� declare ���� ���� ����) 
1) ������ �����ϸ鼭 ���ÿ� ���� �Ҵ�(�ʱ�ȭ)�ϴ� ��� 
����: �����̸� ����Ÿ�� := ��;
����Ÿ��: ����, ����, ��¥ ... �䳢�̻��� �������� �ȵǿ� (:=) 
:= se llama assignment (�Ҵ�)/ in Korean, ���Կ����� which is an equivalent of =
assignment not of distribution (�Ҵ�) but more of designating a title 
2)������ ���� �ϰ�; ���� �Ҵ�(�ʱ�ȭ)���� �ʴ� ��� 
  �����̸� ������Ÿ��; 
  - �ݵ�� �ش� ���������� ����� ���� �־���Ѵ� (�� �� ���� �� ���) 
  - �ʱ�ȭ ���� ���� ������ begin��� �ȿ��� �ݵ�� �ʱ�ȭ�� �ؾ��Ѵ� 
  - �ʱ�ȭ�Ѵ�: ���� �����Ѵ� (��� �ѹ��� �����ؾ��Ѵ�) 
PL/SQL�� ���� �̸��� ��/�ҹ��ڸ� �������� ����
������ ������ ����� ���� �����մϴ�!! 
a := 'abc'
b := 'ABC'
> �̷��� a�� b�� �ΰ��� 
*/

-- || ���ʰ� �������� �ٿ��� �ϳ��� ���ڿ��� ����� by. pipeline

declare -- ���� �����
    -- ���� ����� ���ÿ� �ʱ�ȭ 
    v_age number(3) := 16;  
    -- = �� ���� ��, := ������ �� 
    
    --���� ���� �ϴ� ��� 
    v_name varchar2(20);
    -- ���� �������� ����, �̸��� �ٿ��ִ� ��> �����Ѵٶ�� ǥ�� 
begin -- ����� 
    -- ȭ��/�ܼ� ��� 
    dbms_output.put_line('����: ' ||v_age); 
    -- �̰Ž� �Լ���/ �� ������ ���?  
    -- v_name �� �ʱ�ȭ���� ���� ����, v_namedms null
    -- ����ο��� �ʱ�ȭ���� ���� ������ ����ο��� �ʱ�ȭ(���� ����)�� 
    v_name := '����';
    dbms_output.put_line('�̸�: '|| v_name); 
end; 
/

-- ������� 
-- declare, declaration (����): ������ �̸��� ������ ������ Ÿ���� ���ϴ� �� 
-- assign, assignment(�Ҵ�): ����� ������ ���� ����/���� �ϴ� �� (:=) 
--initialize, initialization(�ʱ�ȭ): ������ ���ʷ� ���� ����(�Ҵ�)�ϴ� �� 


accept p_age prompt '���̰� ��� �Ǽ���~?';
-- prompt â �� ������,,,! 
-- ���� �Է��ϸ� p_age������ ����ȴ� 
declare 
    v_age number := &p_age;
    --&������: ������Ʈ â���� �Է¹��� ���� �����ϴ� ������ ���� ( reference) 
    -- �����Ѵ� ~ ã�ư��� 
    -- prompt â�� value�� ã�ư����� variable �տ� & �ٿ��ش� 
begin
    dbms_output.put_line('����� ���̴� '||v_age);
end;
/
 
-- ������Ʈ â���� ���簢���� ���ο� ���� ���̸� �Է¹޾Ƽ�, 
-- ���簢���� ���̸� ����ϰ�, �� ����� ȭ��(�ܼ�)�� ��� 
accept t_area prompt '���ο� ������ ���̸� �Է��Ͻÿ�';

-- length * width 

accept t_width prompt '������ ���̸� �Է��Ͻÿ�';
accept t_height prompt '������ ���̸� �Է��Ͻÿ�';

declare 
    t_area number := &t_width * &t_height;
begin 
    dbms_output.put_line('���簢���� ���̴�'||t_area);
end;
/
accept t_width prompt '������ ���̸� �Է��Ͻÿ�';
accept t_height prompt '������ ���̸� �Է��Ͻÿ�';
begin 
  dbms_output.put_line('���簢���� ���̴�'||(&t_width * &t_height));
  end;
/

accept p_width prompt '������ ���̸� �Է��Ͻÿ�';
accept p_height prompt '������ ���̸� �Է��Ͻÿ�';
declare 
    v_width number := &p_width;
    v_height number := &p_height;
    v_area number;
begin 
    v_area := v_width * v_height;
    dbms_output.put_line('���� = '||v_width);
    dbms_output.put_line('���� = '||v_height);
    dbms_output.put_line('���� = '||v_area);
end;
/
    










