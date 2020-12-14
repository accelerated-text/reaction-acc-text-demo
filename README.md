# Accelerated Text Import to Reaction Commerce Demo

Integration between [Reaction Commerce](https://www.reactioncommerce.com/index) and [Accelerated Text](https://github.com/tokenmill/accelerated-text) to provide product descriptions in Reaction run e-shop.

The following video demonstrates the whole process of Accelerated Text working together with Reaction Commerce to 
privide the product descriptions.

[![Porduct descriptions with Accelerated Text and Reaction Commerce](https://raw.githubusercontent.com/tokenmill/reaction-acc-text-demo/master/accelerated-text-screenshot.png)](http://www.youtube.com/watch?v=uyumlEabU2c "acc-text-react-comm")


# Quick start

- `make run` should start up everything.

- Wait till Reaction Commerce is ready by checking [localhost:4080](http://localhost:4080)

- Login with admin credentials (they are printed out in the console)

- Go to Settings/Accelerated Text Import Tool

- Select description type (eg. Pants)

- Upload CSV. **Hint:** you can use csv provided in `data` folder of this project. For `Pants` document plan use `pants.csv`

- Press `Import CSV` and wait till all of the products are uploaded

# Changing Descriptions

- Go to [localhost:8080](http://localhost:8080)

- Select Document Plan you have been using, eg. `Pants`

- Make changes

- Now next upload should use new descriptions for products
