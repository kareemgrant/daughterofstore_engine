store1 = Store.create(name: "Xmen", path: "xmen", description: "all things xmen", status: "pending")
store2 = Store.create(name: "Avengers", path: "avengers", description: "all things avengers", status: "online")
store3 = Store.create(name: "Justice League", path: "justice-league", description: "all things justice league", status: "online")

user1 = User.create(full_name: "Professor X", email: "admin@example.com", password: "password")
user2 = User.create(full_name: "Wolverine", email: "wolverine@example.com", password: "password")
user3 = User.create(full_name: "Ironman", email: "ironmanw@example.com", password: "password")
user4 = User.create(full_name: "Batman", email: "batman@example.com", password: "password")
user5 = User.create(full_name: "Magneto", email: "magneto@example.com", password: "password")
User.create(full_name: "Logan Sears", display_name: "Logan", email: "lsears322@gmail.com", password: "password")

user1.assign_super_admin
user1.super_admin = true
user1.save

UserStoreRole.create({user_id: 2, store_id: 1, role: 'admin'})
UserStoreRole.create({user_id: 3, store_id: 2, role: 'stocker'})
UserStoreRole.create({user_id: 4, store_id: 3, role: 'admin'})

Auction.create(store_id: store1.id, expiration_date: (Time.now + 12000), starting_bid: 0, shipping_options: 'International', active: true)
Product.create(auction_id: 1, title: 'Product 1', description: 'This is a description', price: 1000, active: true)
PaymentOption.create(auction_id: 1, type: 'credit card')
