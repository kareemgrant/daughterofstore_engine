store1 = Store.create(name: "Xmen", path: "xmen", description: "all things xmen", status: "pending")
store2 = Store.create(name: "Avengers", path: "avengers", description: "all things avengers", status: "online")
store3 = Store.create(name: "Justice League", path: "justice-league", description: "all things justice league", status: "online")
store4 = Store.create(name: "Spacely Sprockets", path: "spacely-sprockets", description: "For those who like rusty stuff from junkyards", status: "online")
store5 = Store.create(name: "Crazy Comics", path: "crazy-comics", description: "All things comics", status: "online")
store6 = Store.create(name: "Collectible Cars", path: "collectible-cars", description: "The #1 Place for Car Enthusiasts", status: "online")
store7 = Store.create(name: "Antiquated Antiques", path: "antiques", description: "The kind of things old people have", status: "online")

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
UserStoreRole.create({user_id: user6.id, store_id: store5.id, role: 'admin'})

auction1 = Auction.create(store_id: store4.id, expiration_date: DateTime.new(2013, 5, 2), starting_bid: 0, shipping_options: 'international', active: true)
auction2 = Auction.create(store_id: store4.id, expiration_date: (Time.now + 86400), starting_bid: 0, shipping_options: 'international', active: true)
auction3 = Auction.create(store_id: store4.id, expiration_date: (Time.now + 172800), starting_bid: 0, shipping_options: 'international', active: true)
auction4 = Auction.create(store_id: store4.id, expiration_date: (Time.now + 345600), starting_bid: 0, shipping_options: 'international', active: true)
auction5 = Auction.create(store_id: store4.id, expiration_date: (Time.now + 86400), starting_bid: 0, shipping_options: 'international', active: true)
auction6 = Auction.create(store_id: store5.id, expiration_date: (Time.now + 345600), starting_bid: 0, shipping_options: 'international', active: true)
auction7 = Auction.create(store_id: store5.id, expiration_date: (Time.now + 172800), starting_bid: 0, shipping_options: 'international', active: true)
auction8 = Auction.create(store_id: store5.id, expiration_date: (Time.now + 43200), starting_bid: 0, shipping_options: 'international', active: true)
auction9 = Auction.create(store_id: store5.id, expiration_date: (Time.now + 86400), starting_bid: 0, shipping_options: 'international', active: true)
auction10 = Auction.create(store_id: store5.id, expiration_date: (Time.now + 345600), starting_bid: 0, shipping_options: 'international', active: true)
auction11 = Auction.create(store_id: store6.id, expiration_date: (Time.now + 43200), starting_bid: 0, shipping_options: 'international', active: true)
auction12 = Auction.create(store_id: store6.id, expiration_date: (Time.now + 345600), starting_bid: 0, shipping_options: 'international', active: true)
auction13 = Auction.create(store_id: store6.id, expiration_date: (Time.now + 86400), starting_bid: 0, shipping_options: 'international', active: true)
auction14 = Auction.create(store_id: store6.id, expiration_date: (Time.now + 172800), starting_bid: 0, shipping_options: 'international', active: true)
auction15 = Auction.create(store_id: store6.id, expiration_date: (Time.now + 86400), starting_bid: 0, shipping_options: 'international', active: true)

file = File.open('./public/images/rusty_rocket_ship.jpg')
Product.create(auction_id: auction1.id, title: 'Rusty Rocket Ship', description: 'This old lady was the prototype for Apollo 11. I stole her from NASA after they threw in a junkyard. I bet this baby is worth millions', active: true, photo: file)

file = File.open('./public/images/rusty_bicycle.jpg')
Product.create(auction_id: auction2.id, title: 'Rusty Bicycle', description: 'My grandaddy rode this bad boy to and from school, uphill both ways, in the snow.', active: true, photo: file)

file = File.open('./public/images/gear.jpg')
Product.create(auction_id: auction3.id, title: 'Rocket Gear', description: "This might be the only thing I have that isn't covered in rust", active: true, photo: file)

file = File.open('./public/images/thingamajig.jpg')
Product.create(auction_id: auction4.id, title: 'Thingy Majig', description: 'The hell if I know what this is.', active: true, photo: file)

file = File.open('./public/images/spitoon.jpg')
Product.create(auction_id: auction5.id, title: "Grandad's Spitoon", description: "I forgot I had this until I found it out back in the shed. It's in gently used condition.", active: true, photo: file)

file = File.open('./public/images/superman-figure.jpg')
Product.create(auction_id: auction6.id, title: 'Ultra Rare Superman Action Figure', description: "Let's be honest, Superman would kick Batman's ass.", active: true, photo: file)

file = File.open('./public/images/spiderman-1.jpg')
Product.create(auction_id: auction7.id, title: 'Spiderman Issue #1', description: 'Still in packaging.', active: true, photo: file)

file = File.open('./public/images/green-lantern.jpg')
Product.create(auction_id: auction8.id, title: 'Green Lantern Rare Issue', description: 'Gently used.', active: true, photo: file)

file = File.open('./public/images/batman-ninja-star.jpg')
Product.create(auction_id: auction9.id, title: 'Batman Ninja Star', description: 'Disclaimer: not responsible for any personal injuries resulting from buying this item.', active: true, photo: file)

file = File.open('./public/images/samarai-sword.jpg')
Product.create(auction_id: auction10.id, title: 'Samurai Sword', description: 'Just what every true nerd needs on his wall.', active: true, photo: file)

file = File.open('./public/images/austen-healey-3000-gibraltar.jpg')
Product.create(auction_id: auction11.id, title: 'Austen Healey 3000 Gibraltar', description: 'Perfect for the man in his mid-life crisis.', active: true, photo: file)

file = File.open('./public/images/cadillac-ser-62-de-ville.jpg')
Product.create(auction_id: auction12.id, title: 'Cadillac Ser 62 De Ville', description: 'Perfect for the man in his mid-life crisis.', active: true, photo: file)

file = File.open('./public/images/cadillac-type-57.jpg')
Product.create(auction_id: auction13.id, title: 'Cadillac Type 57', description: 'Perfect for the man in his mid-life crisis.', active: true, photo: file)

file = File.open('./public/images/plymouth-muscle-car.jpg')
Product.create(auction_id: auction14.id, title: 'Plymouth Muscle Car', description: 'Perfect for the man in his mid-life crisis.', active: true, photo: file)

file = File.open('./public/images/shelby-american-muscle.jpg')
Product.create(auction_id: auction15.id, title: 'Shelby All American Muscle', description: 'Perfect for the man in his mid-life crisis.', active: true, photo: file)

PaymentOption.create(auction_id: auction1.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction2.id, payment_type: 'cash')
PaymentOption.create(auction_id: auction3.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction4.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction5.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction6.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction7.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction8.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction9.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction10.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction11.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction12.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction13.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction14.id, payment_type: 'credit')
PaymentOption.create(auction_id: auction15.id, payment_type: 'credit')
