

CREATE OR REPLACE PROCEDURE all_tables(databasename text, tablename text) AS
$$
    declare r record;
    begin
        for r in select * from information_schema.tables WHERE table_catalog = databasename AND table_name = tablename
        loop
            raise info '%', r;
        end loop;
    end;
$$ language plpgsql;

call all_tables('rk2', 'cooperator');




--
CREATE OR REPLACE PROCEDURE RemoveDuplicates( tablename text)AS
$$
BEGIN
  DELETE t2
    FROM information_schema.tables WHERE table_name = tablename t1,
		information_schema.tables WHERE  table_name = tablename t2
  WHERE t1.id < t2.id
    AND t1.attname = t2.attname
    
END
$$ language plpgsql;
