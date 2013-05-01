store1 = Store.create(name: "Xmen", path: "xmen", description: "all things xmen", status: "pending")
store2 = Store.create(name: "Avengers", path: "avengers", description: "all things avengers", status: "online")
store3 = Store.create(name: "Justice League", path: "justice-league", description: "all things justice league", status: "online")
store4 = Store.create(name: "Spacely Sprockets", path: "spacely-sprockets", description: "For those who like rusty stuff from junkyards", status: "online")

User.skip_callback(:save, :before, :update_stripe)

user1 = User.create(full_name: "Professor X", email: "admin@example.com", password: "password")
user2 = User.create(full_name: "Wolverine", email: "wolverine@example.com", password: "password")
user3 = User.create(full_name: "Ironman", email: "ironmanw@example.com", password: "password")
user4 = User.create(full_name: "Batman", email: "batman@example.com", password: "password")
user5 = User.create(full_name: "Magneto", email: "magneto@example.com", password: "password")
user6 = User.create(full_name: "Logan Sears", display_name: "Logan", email: "lsears322@gmail.com", password: "password")

user1.assign_super_admin
user1.super_admin = true
user1.save

User.set_callback(:save, :before, :update_stripe)

UserStoreRole.create({user_id: user2.id, store_id: store1.id, role: 'admin'})
UserStoreRole.create({user_id: user3.id, store_id: store2.id, role: 'stocker'})
UserStoreRole.create({user_id: user4.id, store_id: store3.id, role: 'admin'})
UserStoreRole.create({user_id: user5.id, store_id: store4.id, role: 'admin'})

Auction.create(store_id: store4.id, expiration_date: Time.new(2012, 04, 30), starting_bid: 0, shipping_options: 'International', active: true)
Auction.create(store_id: store4.id, expiration_date: (Time.now + 86400), starting_bid: 0, shipping_options: 'International', active: true)

Product.create(auction_id: 1, title: 'Rusty Rocket Ship', description: 'This old lady was the prototype for Apollo 11. I stole her from NASA after they threw in a junkyard. I bet this baby is worth millions', price: 1000, active: true)
Product.create(auction_id: 2, title: 'Rusty Bicycle', description: 'My grandaddy rode this bad boy to and from school, uphill both ways, in the snow.', price: 1000, active: true)

PaymentOption.create(auction_id: 1, type: 'credit card')
PaymentOption.create(auction_id: 2, type: 'cash')
