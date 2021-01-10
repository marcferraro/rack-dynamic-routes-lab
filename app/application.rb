require 'pry'
class Application

    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)
        # binding.pry
        if req.path.match(/items/)
            @@items.include?req.path.split("/items/").last
            item = req.path.split("/items/").last
            if item_names.include? item
                resp.write price_search(item)
                resp.status = 200
            else
                resp.write "Item not found"
                resp.status = 400
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end

    def price_search(name)
        @@items.select {|item| item.name == name}.last.price
    end

    def item_names
        @@items.map {|item| item.name}
    end
end