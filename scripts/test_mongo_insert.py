from pymongo import MongoClient
import random
from datetime import datetime

client = MongoClient('10.6.0.2', 27017)
#client = MongoClient('127.0.0.1', 27017)
db = client.test_database
collection = db.test_collection

docs = []
for i in range(20):
    d = {
            'timestamp' : datetime.now(),
            'channel' : random.randint(1000,8000)
        }
    docs.append(d)

result = collection.insert_many(docs)
print(result.inserted_ids)

