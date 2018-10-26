from pymongo import MongoClient

"""
Test Read

Tests the ability to read records from the database.
"""

#client = MongoClient('10.6.0.1', 27017)
client = MongoClient('127.0.0.1', 27017)
db = client.test_database
collection = db.test_collection

for doc in collection.find():
    print(doc)

