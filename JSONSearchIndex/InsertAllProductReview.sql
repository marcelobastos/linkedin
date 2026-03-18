INSERT ALL
   WHEN PRODUCT_REVIEW = 1  THEN
         INTO product (PRODUCT_ID, PRODUCT_NAME)
               VALUES (PRODUCT_ID, PRODUCT_NAME)
   WHEN PRODUCT_REVIEW IS NOT NULL THEN
         INTO review (REVIEW_ID, PRODUCT_ID, REVIEW_JSON)
              VALUES (REVIEW_ID, PRODUCT_ID, REVIEW)
WITH cte (PRODUCT_REVIEW, PRODUCT_ID, PRODUCT_NAME, REVIEW_ID, REVIEW)
AS ( 
        SELECT  DENSE_RANK() OVER (ORDER BY J.PRODUCT_ID, REVIEW_ID) AS PRODUCT_REVIEW,
                J.PRODUCT_ID, J.PRODUCT_NAME, J.REVIEW_ID, J.REVIEW
        FROM JSON_TABLE(
 q''{
  "product_reviews": {
    "product_name": "Samsung Galaxy A14 5G",
    "product_id": "B0C1Q3MVBP",
    "reviews": [
      {
        "review_id": "R001",
        "customer": {
          "customer_id": "CUST1001",
          "name": "Ethan Miller",
          "email": "ethan.miller@webmail.com"
        },
        "rating": 5,
        "title": "Excellent Budget Smartphone – Great Value for the Price!",
        "review_text": "Got this for my teenager and it's perfect. 90Hz screen is smooth, battery lasts all day, and 5G works great. Camera is decent for the price point. Highly recommend!"
      },
      {
        "review_id": "R002",
        "customer": {
          "customer_id": "CUST1002",
          "name": "Sophia Chen",
          "email": "sophia.chen@emailprovider.net"
        },
        "rating": 4,
        "title": "Good phone for basic use",
        "review_text": "Solid performance for everyday tasks. Battery life is impressive - 2 days with moderate use. Camera could be better in low light. Overall, satisfied with purchase."
      },
      {
        "review_id": "R003",
        "customer": {
          "customer_id": "CUST1003",
          "name": "Marcus Johnson",
          "email": "marcus.j@fastmail.org"
        },
        "rating": 5,
        "title": "Best budget 5G phone",
        "review_text": "Unlocked, works with T-Mobile perfectly. Setup was easy, screen is bright and colorful. For under $200, you can't beat this phone. Android 13 runs smooth."
      },
      {
        "review_id": "R004",
        "customer": {
          "customer_id": "CUST1004",
          "name": "Isabella Garcia",
          "email": "isabella.garcia@outlook.com"
        },
        "rating": 3,
        "title": "Decent but has some lag",
        "review_text": "Phone works but occasionally lags when switching apps. Camera quality is okay. Battery drains faster than expected with 5G on. For the price, it's acceptable."
      },
      {
        "review_id": "R005",
        "customer": {
          "customer_id": "CUST1005",
          "name": "Daniel Kim",
          "email": "daniel.kim@zoho.com"
        },
        "rating": 5,
        "title": "Perfect for seniors",
        "review_text": "Bought for my mother. Large screen makes text easy to read. Battery lasts long and charging is fast. Simple interface. Great value for a reliable phone."
      },
      {
        "review_id": "R006",
        "customer": {
          "customer_id": "CUST1006",
          "name": "Olivia Brown",
          "email": "olivia.b@proton.me"
        },
        "rating": 4,
        "title": "Great features for price",
        "review_text": "Like the expandable storage - added 256GB card. 5G is fast. Screen resolution is good. Wish it had better water resistance. Still, very happy with purchase."
      },
      {
        "review_id": "R007",
        "customer": {
          "customer_id": "CUST1007",
          "name": "James Wilson",
          "email": "jwilson@icloud.com"
        },
        "rating": 2,
        "title": "Disappointed with performance",
        "review_text": "Phone freezes sometimes and apps crash. Tried resetting but still issues. Maybe got a defective unit. Returning for replacement. Hope next one works better."
      },
      {
        "review_id": "R008",
        "customer": {
          "customer_id": "CUST1008",
          "name": "Emma Davis",
          "email": "emma.davis@mail.com"
        },
        "rating": 5,
        "title": "Excellent value for money",
        "review_text": "Upgraded from A10 and huge difference. 5G is blazing fast, screen is gorgeous, battery improved. Samsung software keeps getting better. Very happy customer."
      }
    ]
  }
}
'',
        '$.product_reviews'
                COLUMNS (product_id   PATH '$.product_id',
                        product_name PATH '$.product_name',
                        NESTED reviews[*] 
                                COLUMNS(review_id  PATH '$.review_id',
                                        review CLOB FORMAT JSON PATH '$')
                        ) 
        ) J
)
SELECT * FROM CTE
