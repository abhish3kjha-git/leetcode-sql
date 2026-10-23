CREATE PROCEDURE UnpivotProducts()
BEGIN
	# Write your MySQL query statement below.

    -- select product_id , 'LC_Store' as store, LC_Store as price from products where LC_Store is not null
    -- union all
    -- select product_id, 'Nozama' as store, Nozama as price from products where Nozama is not null
    -- union all
    -- select product_id, 'Shop' as store, Shop as price from products where Shop is not null
    -- union all
    -- select product_id, 'Souq' as store, Souq as price from products where Souq is not null;

    SET SESSION group_concat_max_len = 1000000;
    SET @case_stmt = NULL;

	SELECT GROUP_CONCAT(
            'SELECT product_id, "', COLUMN_NAME, '" AS store, ', COLUMN_NAME, ' AS price FROM Products WHERE ', COLUMN_NAME,' IS NOT NULL' SEPARATOR " UNION "
        )
    INTO @case_stmt
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME="Products" AND COLUMN_NAME != "product_id";

    SET @sql_query = @case_stmt;

    PREPARE final_sql_query FROM @sql_query;
    EXECUTE final_sql_query;
    DEALLOCATE PREPARE final_sql_query;
	
END