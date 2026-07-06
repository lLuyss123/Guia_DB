CREATE TABLE riwi_cities (
    city_id SERIAL PRIMARY KEY,
    city_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE riwi_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE riwi_suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL UNIQUE,
    city_id INT NOT NULL,

    CONSTRAINT fk_supplier_city
        FOREIGN KEY (city_id)
        REFERENCES riwi_cities(city_id)
);

CREATE TABLE riwi_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES riwi_categories(category_id)
);

CREATE TABLE riwi_warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    warehouse_name VARCHAR(150) NOT NULL UNIQUE,
    city_id INT NOT NULL,

    CONSTRAINT fk_warehouse_city
        FOREIGN KEY (city_id)
        REFERENCES riwi_cities(city_id)
);

CREATE TABLE riwi_inventory_movements (
    movement_id SERIAL PRIMARY KEY,
    movement_date DATE NOT NULL,

    supplier_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    product_id INT NOT NULL,

    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,

    movement_type VARCHAR(10) NOT NULL,
    purchase_order VARCHAR(20) NOT NULL,

    CONSTRAINT fk_movement_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES riwi_suppliers(supplier_id),

    CONSTRAINT fk_movement_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES riwi_warehouses(warehouse_id),

    CONSTRAINT fk_movement_product
        FOREIGN KEY (product_id)
        REFERENCES riwi_products(product_id)
);