DELIMITER //
Create procedure order_status( IN t_year INT,
                                    IN t_month INT )
  BEGIN 
    select orderNumber,
               orderdate,
               status
      from orders
        where year(orderDate) = t_year
            AND
                month(orderDate) = t_month;
  END //
DELIMITER ;

call order_status(2005, 4);

select *,
     CASE
      WHEN amount < 25000 THEN 'Silver'
      WHEN amount BETWEEN 25000 AND 50000 THEN 'Gold'
            ELSE 'Platinum'
            END AS Status
  from payments;

DELIMITER //

CREATE FUNCTION pur_stat(
cid int
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE stat VARCHAR(20);
    DECLARE credit numeric;
    SET credit = (select sum(Amount) from Payment where Cust_number = cid);

    IF credit > 50000 THEN
        SET stat = 'platinum';
    ELSEIF (credit >= 25000 AND 
            credit <= 50000) THEN
        SET stat = 'gold';
    ELSEIF credit < 25000 THEN
        SET stat = 'silver';
    END IF;
    RETURN (stat);
END
DELIMITER ;

CALL customer_status( 103 );

select c.customerNumber,
     c.customerName,
       o.status
  from customers c
    LEFT JOIN orders o
    USING (customerNumber);

DELIMITER $$
CREATE TRIGGER trg_movies_update
AFTER DELETE ON movies
FOR EACH ROW
BEGIN
    UPDATE rentals
    SET movieid = id
    WHERE movieid = OLD.id ;
END;

DELIMITER $$
CREATE TRIGGER trg_movies_delete 
AFTER DELETE ON movies 
FOR EACH ROW 
BEGIN
    DELETE FROM  rentals
    WHERE movieid 
    NOT IN (SELECT DISTINCT id FROM movies);
    END;
    
DELIMITER ;

select *
  from employee
    order by salary desc
      limit 2,1;
      
select *,
     dense_rank () OVER (order by salary desc) as Rank_salary
  from employee;
  
