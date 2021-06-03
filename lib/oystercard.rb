class Oystercard
    attr_reader :balance, :in_journey, :entry_station

    MAX_VALUE = 90
    MINIMUM = 1

    def initialize
        @balance = 0
    end

    def top_up(amount)
        @balance += amount
        limit_exceeded
    end

    def limit_exceeded
        fail "You have exceeded the £#{MAX_VALUE} maximum" if @balance > MAX_VALUE
    end

    def touch_in(entry_station)
        fail "Sorry. Insufficient funds. You need at least £#{Oystercard::MINIMUM} to travel." unless (@balance >= MINIMUM)
        @entry_station = entry_station
        in_journey?
    end

    def touch_out
        deduct
        @entry_station = nil
    end

    def in_journey?
        !!entry_station
        # @entry_station = nil ? @in_journey = false : @in_journey = true
    end
    
    private
    def deduct
        @balance -= MINIMUM
    end


end

# require './lib/oystercard.rb' 
# oystercard = Oystercard.new
# oystercard.top_up(Oystercard::MAX_VALUE)
# oystercard.balance
# oystercard.touch_in
# oystercard.deduct(Oystercard::MINIMUM)
# oystercard.touch_out
# oystercard.balance
# 
