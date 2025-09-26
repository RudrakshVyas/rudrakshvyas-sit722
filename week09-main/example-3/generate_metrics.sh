#!/bin/bash

echo "===== STEP 1: Health checks ====="
curl -s http://localhost:8000/health && echo
curl -s http://localhost:8001/health && echo

echo "===== STEP 2: Create Products ====="
curl -s -X POST http://localhost:8000/products/ \
  -H "Content-Type: application/json" \
  -d '{"name":"Phone","description":"15 Pro","price":1999,"stock_quantity":25}' && echo

curl -s -X POST http://localhost:8000/products/ \
  -H "Content-Type: application/json" \
  -d '{"name":"Laptop","description":"Gaming Laptop","price":2999,"stock_quantity":10}' && echo

echo "===== STEP 3: List Products ====="
curl -s http://localhost:8000/products/ && echo

echo "===== STEP 4: Deduct Stock ====="
curl -s -X PATCH http://localhost:8000/products/1/deduct-stock \
  -H "Content-Type: application/json" \
  -d '{"quantity": 5}' && echo

echo "===== STEP 5: Create Orders ====="
for i in {1..3}; do
  curl -s -X POST http://localhost:8001/orders/ \
    -H "Content-Type: application/json" \
    -d '{"customer_name":"Rudraksh","items":[{"product_id":1,"quantity":2}]}' && echo
done

echo "===== STEP 6: Verify Orders ====="
curl -s http://localhost:8001/orders/ && echo

echo "===== Done! Now refresh Grafana queries. ====="
