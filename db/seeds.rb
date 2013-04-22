store1 = Store.create(name: "Xmen", path: "xmen", description: "all things xmen", status: "pending")
store2 = Store.create(name: "Avengers", path: "avengers", description: "all things avengers", status: "online")
store3 = Store.create(name: "Justice League", path: "justice-league", description: "all things justice league", status: "online")

user4 = User.create(full_name: "Professor X", email: "admin@example.com", password: "password")
user5 = User.create(full_name: "Wolverine", email: "wolverine@example.com", password: "password")
user6 = User.create(full_name: "Ironman", email: "ironmanw@example.com", password: "password")
user7 = User.create(full_name: "Batman", email: "batman@example.com", password: "password")
user8 = User.create(full_name: "Magneto", email: "magneto@example.com", password: "password")

user4.assign_super_admin
user4.super_admin = true
user4.save


UserStoreRole.create({user_id: 5, store_id: 1, role: 'admin'})
UserStoreRole.create({user_id: 6, store_id: 2, role: 'stocker'})
UserStoreRole.create({user_id: 7, store_id: 3, role: 'admin'})


