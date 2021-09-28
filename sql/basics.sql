-- top 10 merchants by sales, warrantable sales
SELECT
o.vendor,
sum(c.plan_purchase_price) as warranty_sales
FROM analytics.order_detail_facts o
LEFT JOIN
analytics.contract_facts c
USING(product_id)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

SELECT
  o.store_id,
  c.seller_name,
  SUM(total_price) AS gmv,
  SUM(actual_warrantable_total) AS gwv
FROM
  analytics.order_facts o
  LEFT JOIN analytics.contract_facts c USING(store_id)
WHERE
  o.ordered_at >= TO_DATE('2021-04-01', 'YYYY-MM-DD')
  AND o.ordered_at < TO_DATE('2021-05-01', 'YYYY-MM-DD')
GROUP BY
  1,
  2

-- sales/warrantable sales per merchant
SELECT
  o.store_id,
  c.seller_name,
  SUM(total_price) AS gmv,
  SUM(actual_warrantable_total) AS gwv
FROM
  analytics.order_facts o
  LEFT JOIN analytics.contract_facts c USING(store_id)
WHERE
  store_id = '845a9ffa-f3e2-430e-b930-0f9f671adc69'
GROUP BY
  1,
  2

-- attach rates by merchant, category

-- Unit Attach Rate - number of warranty plans sold / total number of products sold (Consider only warrantable products)
-- Dollar Attach Rate -  dollar amount of warranty plans sold / total sales of products


SELECT
  o.store_id,
  c.seller_name,
  SUM(total_price) AS gmv,
  SUM(actual_warrantable_total) AS gwv,
  SUM(plan_purchase_price) AS warr_sold,
  SUM(plan_purchase_price)/SUM(actual_warrantable_total) AS attach_rate_dollar,
  COUNT(plan_purchase_price)/SUM(actual_warrantable_total) AS attach_rate_unit
FROM
  analytics.order_facts o
  LEFT JOIN analytics.contract_facts c USING(store_id)
WHERE
  store_id = '845a9ffa-f3e2-430e-b930-0f9f671adc69'
GROUP BY
  1,
  2


SELECT
  o.store_id,
  SUM(total_price) AS gmv,
  SUM(actual_warrantable_total) AS gwv,
  SUM(plan_purchase_price) AS warr_sold,
  SUM(plan_purchase_price)/SUM(actual_warrantable_total) AS attach_rate_dollar,
  COUNT(plan_purchase_price)/SUM(warrantable_item_count) AS attach_rate_unit
FROM
  analytics.order_facts o
  LEFT JOIN analytics.contract_facts c
  USING(store_id)
WHERE
  store_id = '845a9ffa-f3e2-430e-b930-0f9f671adc69'
GROUP BY
  1
