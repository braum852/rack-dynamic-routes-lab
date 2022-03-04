require 'rack'

class Application

@@items = [Item.new("Figs", 3.42), Item.new("Pears", 0.99)]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
        item = req.path.split("/items/").last #strip path info to capture just the price - last instance created in method @name, !@price!
            if item_search = @@items.find{|x| x.name == item}
            resp.write item_search.price
        else
            resp.status = 400
            resp.write "Item not found"
        end
        else
            resp.status = 404 
            resp.write "Route not found"
        end
        resp.finish
    end
    
    end



#Your application should only accept the /items/<ITEM NAME> route. Everything else should 404
#If a user requests /items/<Item Name> it should return the price of that item
#IF a user requests an item that you don't have, then return a 400 and an error message