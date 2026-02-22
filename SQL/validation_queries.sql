-- 1️⃣ Find Low Stock SKUs
SELECT sku_id, SUM(stock_qty) AS total_stock
FROM inventory_transactions
GROUP BY sku_id
HAVING SUM(stock_qty) < 10;

-- 2️⃣ Warehouse Stock Summary
SELECT warehouse_id, SUM(stock_qty) AS total_stock
FROM inventory_transactions
GROUP BY warehouse_id;