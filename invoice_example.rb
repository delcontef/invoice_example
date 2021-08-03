# ruby factura.rb <cantidad> <precio_unitario> <estado>

class Invoice    
    def initialize(qty, u_price, state)
        @qty = qty.to_f()
        @u_price = u_price.to_f()
        @state = state

        puts("qty #{@qty}, u_price #{@u_price}, state #{@state}")
        puts("qty #{@qty.is_a?(Float)}, u_price #{@u_price.is_a?(Float)}, state #{@state.is_a?(Float)}")
    end
end

if(3 != ARGV.length)
    puts("Error calling the program....")
    puts("should be: ruby invoice_example.rb <quantity> <unit_price> <state>")
    puts("Ex: ruby invoice_example.rb 1 2 CA")
else
    invoice = Invoice.new(ARGV[0], ARGV[1], ARGV[2])
end