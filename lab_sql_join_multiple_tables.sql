
use sakila;



-- 1. Write a query to display for each store its store ID, city, and country.
select si.store_id, ad.address, ci.city, co.country 
	from sakila.store si 
		left join sakila.address ad
			on si.address_id = ad.address_id
				left join sakila.city ci
					on ci.city_id = ad.city_id
						left join sakila.country co
							on ci.country_id = co.country_id 
;


-- 2. Write a query to display how much business, in dollars, each store brought in.
select si.store_id, ad.address, sum(p.amount)
from sakila.store si
left join sakila.address ad
on si.address_id = ad. address_id
left join sakila.staff st
on si.store_id = st.store_id
left join sakila.payment p
on st.staff_id = p.staff_id
group by si.store_id
;

-- 3. What is the average running time of films by category?
select ca.name, concat(round(avg(fi.length)) DIV 60, 'h', round(avg(fi.length))  % 60, 'm') as time
from sakila.film as fi
left join sakila.film_category as fc
on  fc.film_id = fi.film_id
left join sakila.category as ca
on  ca.category_id = fc.category_id
group by ca.name
;

-- 4. Which film categories are longest?
select c.name, concat(round(avg(f.length)) DIV 60, 'h', round(avg(f.length))  % 60, 'm') as time
from sakila.film as f
left join sakila.film_category as fc
on  fc.film_id = f.film_id
left join sakila.category as c
on  c.category_id = fc.category_id
group by c.name
order by 2 desc
limit 10
;


-- 5. Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as Qty
from sakila.rental as r
left join sakila.inventory as i
on  i.inventory_id = r.inventory_id
left join sakila.film as f
on i.film_id = f.film_id
group by  f.film_id
order by 2 desc
;


-- 6. List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount) as gross_revenue
from sakila.film as f
left join sakila.film_category as fc
on  fc.film_id = f.film_id
left join sakila.category as c
on  c.category_id = fc.category_id
left join sakila.inventory i
on f.film_id = i.film_id
left join sakila.rental r
on i.inventory_id = r.inventory_id
left join sakila.payment p
on r.rental_id = p.rental_id
group by c.name
limit 5
;


-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select *
from sakila.rental
where return_date is null
;

select f.title, s.store_id,r.rental_date, r.return_date
from sakila.film as f
left join sakila.inventory i
on f.film_id = i.film_id
left join sakila.rental r
on i.inventory_id = r.inventory_id
left join sakila.store s
on s.store_id = i.store_id
where f.title = 'Academy Dinosaur' and s.store_id= 1 and r.return_date is null and r.rental_date is not null