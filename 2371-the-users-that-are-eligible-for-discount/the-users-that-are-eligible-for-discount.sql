CREATE PROCEDURE getUserIDs(startDate DATE, endDate DATE, minAmount INT)
BEGIN
	# Write your MySQL query statement below.
    select distinct user_id from purchases 
    where amount>minAmount and time_stamp between startDate and endDate
    order by 1;
	
END