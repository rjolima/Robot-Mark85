from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb+srv://qa:xperience@cluster0.q4qxt4b.mongodb.net/?retryWrites=true&w=majority')

db = client['markdb']

@keyword('Clean user from database')
def clean_user(user_email):
    users = db['users']
    tasks = db['tasks']

    u = users.find_one({'email': user_email})

    if (u):
        tasks.delete_many({'user': u['_id']})
        users.delete_many({'email': user_email})

@keyword('Remove users from database')
def remove_user(email):
    users = db['users'] 
    users.delete_many({'email': email})
    print('Remove user by' + email)

#Funciona da mesma maneira que o de baixo sem a chave de crypt
#@keyword('Insert users from database')
# def insert_user (name, email2, senha):
#     users = db['users'] 
#     users.insert_one({'name': name, 'email': email2, 'password': senha})
#     print('update user by' + email2)

@keyword('Insert users from database')
def insert_user (user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'], 
        'email': user['email'], 
        'password': hash_pass
    }

    users = db['users'] 
    users.insert_one(doc)
    print(user)