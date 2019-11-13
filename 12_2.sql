--09.19.2019 ex_pkg
/*
�������� -- specification �ۼ� (��) 
-- ��Ű�� ���� (body) �ۼ� (����) 

*/

set serveroutput on; 

create or replace package my_stat 
is
    -- index by table ����� (���� Ÿ���� �����ϰ�, index�� ���� ������ index-by ���̺��� ����)  
-- 
--table_name type_name;
--   �Լ������ 
--   * �Լ� �̸�: sum �Ķ���Ϳ� ���� ���� �迭�� �ִ� ��� ���ҵ��� ���� �����ϴ� �ռ� 
--   * ���: @param arr NumberArray 
--    
--    * �Լ� 2: avg �Ķ���Ϳ� ���޹��� �迭�� �ִ� ��� ���ҵ��� ����� ����ؼ� ���� 
--    * @param arr NumberArray 
--    *@param digit number  ���� ��(���)�� �Ҽ��� ���� �ڸ���, �⺻�� 3 (�Ҽ��� ���� 3�ڸ� ���� ǥ��) 
--    
--    *�Լ� 3: var ���ҵ��� �л��� ����ؼ� ���� 
--          * @param arr NumberArray 
--    *@param digit number  ���� ��(���)�� �Ҽ��� ���� �ڸ���, �⺻�� 3 (�Ҽ��� ���� 3�ڸ� ���� ǥ��)0

--    *�Լ� 4: std ���ҵ��� �л��� ����ؼ� ���� 
--          * @param arr NumberArray 
--    *@param digit number  ���� ��(���)�� �Ҽ��� ���� �ڸ���, �⺻�� 3 (�Ҽ��� ���� 3�ڸ� ���� ǥ��)

--    *�Լ� 6: max ���ҵ��� ǥ�������� ����ؼ� ���� 
--          * @param arr NumberArray 


--    *�Լ� 8: min ���ҵ��� ǥ�������� ����ؼ� ���� 
--          * @param arr NumberArray 

end; 
/


create or replace package my_stat 
is
    -- Ÿ�� ����
     type NumberArray is table of number index by pls_integer; 
    
    -- �Լ� ������Ÿ�� ����
    function sum (arr NumberArray) return number;
    function avg (arr NumberArray, digit number) return number; 
    function var (arr NumberArray, digit number) return number; 
    function std (arr NumberArray, digit number) return number; 
    function max (arr NumberArray) return number;
    function min (arr NumberArray) return number;
    
end;
/

