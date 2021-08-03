# ruby factura.rb <cantidad> <precio_unitario> <estado>

class Invoice
    @@state_map = {
        :Utah       => "ut",
        :Nevada     => "nv",
        :Texas      => "tx",
        :Alabama    => "al",
        :California => "ca",
    }
    
    @@tax_map = {
        @@state_map[:Utah]       => 6.85,
        @@state_map[:Nevada]     => 8.0,
        @@state_map[:Texas]      => 6.25,
        @@state_map[:Alabama]    => 4.0,
        @@state_map[:California] => 8.25,
    }

    @@disc_map = {
        1 => [1000, 3],
        2 => [5000, 5],
        3 => [10000, 10],
        4 => [15000, 15],
    }

    def initialize(state)
        @state = state.to_s().downcase()
        @a_tax = @@tax_map[@state]

        puts("@a_tax: #{@a_tax}")
    end

    def calculate(qty, u_price)
        qty = qty.to_f()
        u_price = u_price.to_f()
        puts("In calculate method. qty: #{qty} u_price: #{u_price}")
    end
end

if(3 != ARGV.length)
    puts("Error calling the program....")
    puts("should be: ruby invoice_example.rb <quantity> <unit_price> <state>")
    puts("Ex: ruby invoice_example.rb 1 2 CA")
else
    invoice = Invoice.new(ARGV[2])
    invoice.calculate(ARGV[0], ARGV[1])
end
