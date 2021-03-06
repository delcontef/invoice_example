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
        0 => [    0,  0],
        1 => [ 1000,  3],
        2 => [ 5000,  5],
        3 => [10000, 10],
        4 => [15000, 15],
    }

    def initialize(state)
        @state = state.to_s().downcase()
        if(false == is_valid_string?(@state,'a', 'z'))
            puts("\nError!\nInvalid state parameter...")
            exit
        end
        @a_tax = @@tax_map[@state]
        if(nil == @a_tax)
            puts("\nError!\nTax information not found!. Please, try again..")
            puts("Available options are:")
            @@state_map.each{|a| puts("     #{a[1]}: #{a[0]}")}
            exit
        end
    end

    def calculate(qty, u_price)
        if(is_valid_string?(qty,'0', '9'))
            qty = qty.to_f()
        else
            puts("\nError!\nInvalid quantity parameter...")
            exit
        end

        if(is_valid_number_string?(u_price))
            u_price = u_price.to_f()
        else
            puts("\nError!\nInvalid unitary price parameter...")
            exit
        end

        total_price = qty * u_price
        total_tax = total_price * @a_tax / 100

        is_found = false
        for i in (0..(@@disc_map.length - 2))
            if((total_price >= @@disc_map[i][0]) && (total_price < @@disc_map[i + 1][0]))
                is_found = true
                break
            end
        end

        if(false == is_found)
            i+=1
        end
        total_disc = total_price * @@disc_map[i][1] / 100
        
        final_value = total_price + total_tax - total_disc
        puts("****************************")
        puts("tax: #{@a_tax}% total tax: #{total_tax} discount: #{total_disc}")
        puts("final_value: #{final_value}")
        puts("****************************")

    end

    private
    def is_valid_string?(str, start, stop)
        is_valid = true
        str.split('').each{|a_char| is_valid &= a_char.between?(start, stop)}
        return is_valid
    end

    def is_valid_number_string?(str)
        is_valid = true
        str.split('').each{|a_char| is_valid &= (a_char.between?('0', '9') || a_char.eql?('.'))}
        return is_valid
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
