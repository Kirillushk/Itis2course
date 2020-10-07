--1
select model,speed,hd
from PC
where price<500
--2
SELECT DISTINCT maker
    FROM Product
    WHERE type = 'Printer'
--3
SELECT model, ram, screen
    FROM Laptop
    WHERE price > CAST('1000' AS MONEY)
--4
Select *
from printer
where color = 'y'
--5
Select model,speed,hd
from pc
where (cd = '12x' or cd='24x') and price<600
--6
SELECT distinct Product.maker, Laptop.speed
    FROM Product, Laptop
    WHERE Product.model = Laptop.model
     AND Laptop.hd >= 10
--7
SELECT model, price
    FROM PC
    WHERE model IN (SELECT model
     FROM Product
     WHERE maker = 'B' AND
     type = 'PC'
     )
union
    SELECT model, price
    FROM Laptop
    WHERE model IN (SELECT model
     FROM Product
     WHERE maker = 'B' AND
     type = 'Laptop'
     )
    UNION
    SELECT model, price
    FROM Printer
    WHERE model IN (SELECT model
     FROM Product
     WHERE maker = 'B' AND
     type = 'Printer'
    )
    --8
    Select distinct maker
from Product
where Product.type = 'PC' and maker not in (
Select distinct maker
from Product
where Product.type = 'Laptop')

--9
SELECT DISTINCT maker
FROM product p,PC
WHERE p.model=pc.model
AND pc.speed>449
--10
SELECT model, price
    FROM Printer pr, (SELECT MAX(price) AS maxprice
                      FROM Printer
                      ) AS mp
    WHERE price = mp.maxprice
--11
SELECT SUM(speed)/COUNT(speed)
    FROM PC
--12
SELECT SUM(speed)/COUNT(speed)
    FROM laptop
where price>1000
--13
select sum(pc.speed) / count(*)
from pc
where pc.model in (select product.model from product
where product.maker = 'a')
--14
Select Ships.class, Ships.name, Classes.country
from Ships
inner join Classes on Ships.class = Classes.class where numGuns >= 10

--15
Select distinct hd
from PC pc1 where (select count(hd)
        from PC pc2
        where pc1.hd = pc2.hd) >= 2

--16
Select distinct m1.model, m2.model, m1.speed, m1.ram
from PC m1, PC m2 where m1.speed = m2.speed and m1.ram = m2.ram and m1.model > m2.model

--17
SELECT DISTINCT p.type, l.model, l.speed
FROM laptop l, product p
WHERE speed < ALL (SELECT speed FROM PC)
AND l.model=p.model
--18
select distinct product.maker, printer.price
from product, printer
where product.model = printer.model
and printer.color = 'y'
and printer.price = (select min(p.price)
from printer p
where p.color = 'y')
--19
select product.maker, sum(laptop.screen) / count(laptop.model)
from product, laptop
where product.type = 'Laptop'
and product.model = laptop.model
group by product.maker
--20
select product.maker,count(*)
from product
where type='pc' group by product.maker
having count(*) >= 3
--21
select product.maker, max(pc.price)
from product, pc
where product.model = pc.model
and product.type = 'pc'
group by product.maker
--22
Select speed, avg(price)
from PC
group by speed
Having speed > 600

--23
Select p1.maker
From Product p1, PC pc1, Laptop l1, Product p2
where p1.model = pc1.model
  and pc1.speed >= 750 and p1.maker = p2.maker
  and l1.speed >= 750 and p2.model = l1.model
group by p1.maker

--24
select distinct product.model
from product, pc, laptop, printer
where /*product.model in(pc.model, laptop.model, printer.model)
and*/ pc.price = (select max(pcc.price) from pc pcc)
and laptop.price = (select max(l.price) from laptop l)
and printer.price = (select max(pr.price) from printer pr)
and (
(pc.price >= laptop.price and pc.price >= printer.price
and product.model = pc.model)
or
(laptop.price >= pc.price and laptop.price >= printer.price
and model = laptop.model)
or
(printer.price >= laptop.price and printer.price >= pc.price
and product.model = printer.model)
)
--25
select distinct product.maker
from product, pc
where product.type = 'pc'
and product.model = pc.model
and pc.ram = (select min(pcc.ram) from pc pcc where pcc.ram <> 0)
and pc.speed = (select max(pccc.speed) from pc pccc
where pccc.ram = (select min(pcc.ram) from pc pcc where pcc.ram <> 0))
and exists(select 'x' from product p
where p.type = 'Printer'
and p.maker = product.maker)
--26
SELECT AVG(price) FROM (
SELECT price FROM pc WHERE model IN
(SELECT model FROM product WHERE maker='a' AND type='pc')
UNION ALL
SELECT price FROM laptop WHERE model IN
(SELECT model FROM product WHERE maker='a' AND type='Laptop')
) as prod
--27
select product.maker, sum(pc.hd) / count(*)
from product, pc
where product.type = 'pc'
and product.model = pc.model
and exists(select 'x' from product p
where p.maker = product.maker
and p.type = 'Printer')
group by product.maker
--28
Select count(maker)
from Product p1
where (select count(model) from Product p2 where p1.maker = p2.maker) = 1

--29
SELECT Income_o.point, Income_o.date, SUM(inc),SUM(out)
FROM Income_o LEFT JOIN
Outcome_o ON Income_o.point = Outcome_o.point AND
Income_o.date = Outcome_o.date
GROUP BY Income_o.point, Income_o.date
UNION
SELECT Outcome_o.point, Outcome_o.date, SUM(inc),SUM(out)
FROM Outcome_o LEFT JOIN
Income_o ON Income_o.point = Outcome_o.point AND
Income_o.date = Outcome_o.date
GROUP BY Outcome_o.point, Outcome_o.date
--30
SELECT DISTINCT point,date,SUM(out) AS out, SUM(inc) AS inc FROM (
SELECT Income.point, Income.date, out, inc
FROM Income LEFT JOIN
Outcome ON Income.point = Outcome.point AND
Income.date = Outcome.date AND Income.code= Outcome.code
UNION ALL
SELECT Outcome.point, Outcome.date, out, inc
FROM Outcome LEFT JOIN
Income ON Income.point = Outcome.point AND
Income.date = Outcome.date AND Income.code=Outcome.code) AS t1
GROUP BY point, date
--31
SELECT class, country
FROM Classes
WHERE bore>=16
--33
SELECT ship
FROM Outcomes
WHERE battle='North Atlantic'
AND result='sunk'
--36
Select distinct s.name  from Ships s, Outcomes o, Classes c
where s.name = s.class
union ((select ship from Outcomes o1, Classes c1 where o1.ship = c1.class) Except (select name from Ships))
-38
select distinct country from Classes c where
    (select count(type) from Classes c1 where type = 'bb' and c1.country = c.country ) > 0 and (select count(type) from Classes c2 where type = 'bc'  and c2.country = c.country) > 0
