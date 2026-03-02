Business Logic & Validation Rules

Database Design (PostgreSQL)  
<img width="781" height="542" alt="image" src="https://github.com/user-attachments/assets/e055018e-8761-49f3-bac0-bf213cdf38d4" />  

<img width="1440" height="474" alt="image" src="https://github.com/user-attachments/assets/185838a9-892e-49fd-a4a6-c5dd71aa369c" />

5.1 Find Stock Quantities

SELECT sku_id, SUM(stock_qty) as total_stock FROM inventory_transactions GROUP BY sku_id ORDER BY total_stock  ; 

<img width="872" height="482" alt="image" src="https://github.com/user-attachments/assets/ebd21985-dc60-450e-9265-7a1425179590" />      

5.2 Find Low Stock SKUs    
SELECT sku_id, SUM(stock_qty) as total_stock    
FROM inventory_transactions GROUP BY sku_id HAVING SUM(stock_qty) <=5  
ORDER BY total_stock;  

<img width="660" height="362" alt="image" src="https://github.com/user-attachments/assets/db841e3c-e971-40fa-b63d-236901fb8ab3" />           
Low Stock Rule    

SELECT sku_id, SUM(stock_qty) as total_stock,  
CASE  
   WHEN (SUM(stock_qty)<5) THEN 'LOW STOCK'  
   ELSE 'OK'  
END AS stock_status    
from inventory_transactions GROUP BY sku_id;           

<img width="925" height="760" alt="image" src="https://github.com/user-attachments/assets/2a7957ae-475b-4f2f-bb5e-338d0bef4610" />        

The system shall flag an SKU as ‘LOW Stock’ when the total available quantity across all warehouses is less than 5 units. 

