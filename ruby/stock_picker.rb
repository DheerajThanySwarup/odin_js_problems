=begin
Implement a method #stock_picker that takes in an array of stock prices, one for each hypothetical day. 
It should return a pair of days representing the best day to buy and the best day to sell. Days start at 0.    
> stock_picker([17,3,6,9,15,8,6,1,10])
=> [1,4]  # for a profit of $15 - $3 == $12
=end


class Stock
    def stock_picker(stock)
        stock = stock.split(/\s*,\s*/).map{|x| x.to_i}
        profit = 0
        for i in 0..stock.length - 1
            j = i+1
            for j in j..stock.length - 1
                diff = stock[j] - stock[i]
                if diff > profit
                    buy = i
                    sell = j
                    profit = diff
                end
            end
        end
        puts "Best day to buy,sell is [#{buy}, #{sell}] for a profit of $#{stock[sell]}- $#{stock[buy]} = $#{stock[sell]-stock[buy]}" 
    end
end

share = Stock.new
puts "Enter the stock prices for each hypothetical day (give input by ',' b/w prices)"
stock_prices = gets.chomp!
share.stock_picker(stock_prices)