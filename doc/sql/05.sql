
#주문내역이 존재하지 않는 상품들만 조회
select
	*
from
	product
where
product_id not in( #not in을 사용해서 주문된 상품 id에 없는 상품만 필터링
#주문된 상품 id 목록 반환
select
product_id 
from
orders);

#exitsts 연산자
#조건을 만족하는 첫번쨰 행을 발견하면 즉시 true를 반환하고 종료 -> 경우에 따라 빠름
#주문된 내역이 있는 상품만 조회
select
	*
from
	product
where
	#인스턴스의 id(product_id)가 주문테이블에 존재하는지 확인
    exists(#행(row) 존재여부만 판단
    select
		1 #목적이 존재여부이기 때문에 반환값은 의미가 없다.
	from 
		orders o
	where
		product.product_id=o.product_id);
        
# where 서브쿼리를 작성해서 2024년 1월에 주문된 상품들만 조회
#1월에 주문 ->2024-01-01 이상, 2024-02-01미만
-- in 버전
select
    *
from
    product
where
    product_id in (
        select
            product_id
        from
            orders
        where
            # 날짜 계산시 between을 쓰면 말일 23:59:59.999999 누락 가능성이 있어
            # therefore >=, < 형태가 권장됨
            order_date >= '2024-01-01'
            and order_date < '2024-02-01'
    );

-- exists 버전
select
    *
from
    product p
where
    exists (
        select
            1
        from
            orders o
        where
            o.product_id = p.product_id
            and o.order_date >= '2024-01-01'
            and o.order_date < '2024-02-01'
    );
    
#from 절에 사용하는 서브쿼리 - 인라인뷰
#서브쿼리이ㅡ 결과를 하나의 테이블로 간주하겠다.(가상테이블)
select *
from (
    select
        product_id,
        product_name,
        product_price,
        case
            when product_price <= 30000 then '저가'
            when product_price <= 100000 then '중가'
            else '고가'
        end as price_range
    from
        product
) as view_table #쿼리 결과를 하나의 가상테이블로도 만들 수 있구나 ->view(캐싱)
where
    price_range = '중가';
 #view_table:인라인뷰를 하나의 테이블록 간주하고 where로 필터링
