UPDATE riwi_suppliers
SET supplier_name = 'Aceros del Norte Colombia S.A.S'
WHERE supplier_id = 1;


-- Primero se busca acá para ver si si está funcionando
SELECT p.product_id, p.product_name
FROM riwi_products p
LEFT JOIN riwi_inventory_movements im
    ON p.product_id = im.product_id
WHERE im.product_id IS NULL;

-- Luego de confirmar se elimina
DELETE FROM riwi_products
WHERE product_id IN (
    SELECT p.product_id
    FROM riwi_products p
    LEFT JOIN riwi_inventory_movements im
        ON p.product_id = im.product_id
    WHERE im.product_id IS NULL
);

-- otra opcion es crear una vista

CREATE VIEW vw_products_without_movements AS
SELECT p.product_id,
       p.product_name
FROM riwi_products p
LEFT JOIN riwi_inventory_movements im
    ON p.product_id = im.product_id
WHERE im.product_id IS NULL;

-- y luego eliminarlo de la lista ayudandonos con la vista

DELETE FROM riwi_products
WHERE product_id = (
    SELECT product_id
    FROM vw_products_without_movements
);