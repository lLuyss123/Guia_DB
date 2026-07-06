--1

CREATE VIEW vw_inventory_stock AS
SELECT
    movement_id,
    product_id,
    warehouse_id,
    supplier_id,
    movement_date,
    movement_type,
    quantity *
    CASE
        WHEN movement_type = 'IN' THEN 1
        ELSE -1
    END AS quantity,
    unit_price,
    purchase_order
FROM riwi_inventory_movements;

SELECT
    p.product_name,
    SUM(v.quantity) AS stock
FROM vw_inventory_stock AS v
INNER JOIN riwi_products AS p
    ON v.product_id = p.product_id
GROUP BY p.product_name;

--2

select riwi_warehouses.warehouse_name, riwi_products.product_name, riwi_inventory_movements.movement_type from riwi_inventory_movements
inner join riwi_warehouses on riwi_inventory_movements.warehouse_id= riwi_warehouses.warehouse_id
inner join riwi_products on riwi_inventory_movements.product_id=riwi_products.product_id;

--3

SELECT
    riwi_suppliers.supplier_name,
    SUM(riwi_inventory_movements.unit_price * riwi_inventory_movements.quantity) AS total
FROM riwi_inventory_movements
INNER JOIN riwi_suppliers
    ON riwi_inventory_movements.supplier_id = riwi_suppliers.supplier_id
WHERE riwi_inventory_movements.movement_type = 'IN'
GROUP BY riwi_suppliers.supplier_name;

--4

select riwi_warehouses.warehouse_name, count(riwi_inventory_movements.warehouse_id) from riwi_inventory_movements
inner join riwi_warehouses on riwi_inventory_movements.warehouse_id = riwi_warehouses.warehouse_id
group by riwi_warehouses.warehouse_name;

--5

SELECT
    riwi_products.product_name,
    SUM(riwi_inventory_movements.quantity) AS total_comprado
FROM riwi_inventory_movements
INNER JOIN riwi_products
    ON riwi_inventory_movements.product_id = riwi_products.product_id
WHERE riwi_inventory_movements.movement_type = 'IN'
GROUP BY riwi_products.product_name
ORDER BY total_comprado DESC
LIMIT 1;

SELECT
    riwi_products.product_name,
    SUM(riwi_inventory_movements.quantity) AS total_salidas
FROM riwi_inventory_movements
INNER JOIN riwi_products
    ON riwi_inventory_movements.product_id = riwi_products.product_id
WHERE riwi_inventory_movements.movement_type = 'OUT'
GROUP BY riwi_products.product_name
ORDER BY total_salidas DESC
LIMIT 1;

-- 6

SELECT
    riwi_warehouses.warehouse_name,
    SUM(vw_inventory_stock.quantity * vw_inventory_stock.unit_price) AS total
FROM vw_inventory_stock
INNER JOIN riwi_warehouses
    ON vw_inventory_stock.warehouse_id = riwi_warehouses.warehouse_id
GROUP BY riwi_warehouses.warehouse_name;