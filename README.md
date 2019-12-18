# Accelerated Text Import to Reaction ECommerce Demo

Integration between Reaction ECommerce and Accelerated Text to provide product descriptions in Reaction run e-shop.

The following video demonstrates the whole process of Accelerated Text working together with Reaction Commerce to 
privide the product descriptions.

[![Porduct descriptions with Accelerated Text and Reaction Commerce](http://img.youtube.com/vi/uyumlEabU2c/0.jpg)](http://www.youtube.com/watch?v=uyumlEabU2c "acc-text-react-comm")


# Quick start

- `make run` should start up everything.

- Wait till Reaction Commerce is ready by checking [localhost:3000](http://localhost:3000)

- Login with admin credentials (they are printed out in the console)

- Go to Settings/Accelerated Text Import Tool

- Select description type (eg. Dresses)

- Upload CSV. **Hint:** you can use csv provided in `data` folder of this project. For dresses use `flipcart-dresses.csv`

- Press `Import CSV` and wait till all of the products are uploaded

# Changing Descriptions

- Go to [localhost:8080](http://localhost:8080)

- Select Document Plan you have been using, eg. `Dresses`

- Make changes

- Now next upload should use new descriptions for products

# Caveats

Currently each import creates new products, old ones needs to be deleted manually. 
