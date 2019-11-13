--dbms_output.put_line

set serveroutput on;

declare
    v_score my_stat.numberarray; 
begin 
    for i in 1..10 loop 
--        v_score(i) := i * 10;
        v_score(i) := trunc(dbms_random.value(0,11));
    end loop;
    
     for i in 1..10 loop 
        dbms_output.put(v_score(i)||' '); 
    end loop; 
    dbms_output.new_line;
    
    dbms_output.put_line('SUM: '||my_stat.sum(v_score)); -- ¸¶Áö¸· varray ¸¦ Áà¾ß ½ÇÇàµÊ 
    dbms_output.put_line('AVG: '||my_stat.avg(v_score)); 
    dbms_output.put_line('VAR: '||my_stat.var(v_score));
    dbms_output.put_line('STD: '||my_stat.std(v_score));
    dbms_output.put_line('MAX: '||my_stat.max(v_score));
    dbms_output.put_line('MIN: '||my_stat.min(v_score));
end;
/
