#주문 +고개 이름 조회
#inner join -> 두 테이블 모두에서 매칭되는 값이 있는 row만 가져온다.
#매칭이 안될경우 -> 해당 row를 가져오지 않는다

SELECT
    o.order_id,
    o.order_date,
    o.customer_id,
    c.customer_name
FROM
    orders o
INNER JOIN
    customers c
ON
    o.customer_id = c.customer_id; #가져오는 데이터(조인)조건
# on과 where의 차이
#on은 조인조건으로 두 테이블을 합쳐서 새로운 가상테이블을 만드는 것
# where은 테이블에 조건을 걸어 필터링 

#주문+주문상세+상품이름
SELECT 
    o.order_id,
    o.order_date, 
    o.customer_id,
    c.customer_name,
    od.quantity,
    p.product_name
FROM
    orders o
INNER JOIN customers c
	ON o.customer_id = c.customer_id
INNER JOIN order_details od 
	ON o.order_id = od.order_id
inner join product p
	on od.product_id=p.product_id;
    
# left join-왼쪽 테이블 기준으로 모두 가져오겠다.
# 왼쪽 테이블(from A left join B) : "A"
#왼쪽 테이블 데이터는 다 표시되고, B는 매칭되는 것만 출력

#고객이 주문을 했는지 여부 customer left join orders ->고객들 id가 모두 기재
# orders left join customers -> orders에는 주문한 고객 id만 기재

insert into
customers(customer_name,customer_phone,customer_address)

value
	('박화목','010-1111-2222','부산시 금정구');

select 
	c.customer_name,
    o.order_id,
    o.order_date
from
	customers c
left outer join orders o   
	on c.customer_id=o.customer_id;
    
#실습) 모든 주문에 대해(orders 테이블 시작으로)
# order_id, customer_name, product_name, quantity를 조회

SELECT
    o.order_id,
    c.customer_name,
    p.product_name,
    od.quantity
FROM
    orders o # ORders에 product_id, customer_id -> 조인해야겠다
INNER JOIN customers c # customers 데이블 데이터는 모두 표현되어야 한다(left join)
    ON o.customer_id = c.customer_id
INNER JOIN order_details od
    ON o.order_id = od.order_id
INNER JOIN product p
    ON od.product_id = p.product_id;
    
#고객이 주문을 했는지 여부를 파악하고 싶다.
#left join을 한 이유:INNER JOIN을 하면 주문이 남아있는 고객 출력
#leftjoin을 하면 모든 고객들 데이터는 남아있음 ->주문없음 상태를 출력가능(null)
select
	*
from 
	customers c
    left join orders  o
    on c.customer_id=o.customer_id

where #order_id가 null ->주문을 안 했다.
	o.order_id is null;
    
#고객(fromn customers)별 총 주문 금액(상품 가격*갯수)을 집계해보자
#고객 -> 주문 -> 주문 상세(갯수) -> 상품(상품가격)
select
	c.customer_id,
    c.customer_name,
    sum(p.product_price* od.quantity) as 'total_order_price'
from
	customers c
    inner join orders 
		on c.customer_id=o.customer_id
	inner join oreder_details od
		on o.order_id=od.order_id
	inner join product p
		on od.product_id=p.product_id
group by 
	c.customer_id,c.customer_name;
    
#상품별(from product) 주문(order_detail) 수 출력
#product left join order_detail ->주문이 0번인 상품도 함께 보여야 하기 때문
select
	p.product_id,
    p.product_name,
    count(od.order_id) as 'order_count' #order_detail 한 row가 한번의 주문횟수를 의미
    #count(*) ->null row도 카운팅한다for#count(컬럼) -> null row는 카운팅 안 한다.
    
from
	product p
left join
	order_details od
    on p.product_id = od.product_id
group by
	p.product_id, 
    p.product_name;

# 주문이 한 번도 없는 상품을 조회(join)





     