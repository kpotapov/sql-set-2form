sql-set-2form
=============

it decomposes sql insert statement from form (1) into form (2).  
1. input --  1) INSERT INTO table (col1, col2) VALUES(v1,v2),(v3,v4);   
2. output -- 2) INSERT INTO table SET col1=v1, col2=v2;  
             INSERT INTO table SET col1=v3, col2=v4;  
