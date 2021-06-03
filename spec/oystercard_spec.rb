require 'oystercard.rb'

describe Oystercard do
    let(:station) { double :station }

    it 'has a zero balance when it is brand new' do
        expect(subject.balance).to eq(0)
    end

    it 'can accept a top up of the balance' do
        # expect(subject.balance).to eq(0)
        # subject.top_up(10)
        # expect(subject.balance).to eq(10)
        # was unable to set up test comparing balance before and after top_up on one line`
        # can be achieved with ''.to change'
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'will not allow a top up over £90' do
        expect{subject.top_up(Oystercard::MAX_VALUE + 1)}.to raise_error("You have exceeded the £#{Oystercard::MAX_VALUE} maximum")
    end

    it 'allows the user to spend from their balance' do
        subject.top_up(Oystercard::MAX_VALUE)
        expect{ subject.touch_out }.to change{ subject.balance }.by -Oystercard::MINIMUM
    end

    it 'it allows the user to touch in, activating a journey' do
        subject.top_up(Oystercard::MINIMUM)
        # expect(subject.touch_in(station)).to eq(in_journey?)
        subject.touch_in(station)
        expect(subject).to be_in_journeygit
    end

    it 'it allows the user to touch out, ending a journey' do
        expect(subject.touch_out).to eq(subject.in_journey)
    end

    context '#insufficient funds' do
    let(:balance) {balance = 0}
        it 'does not allow a journey to begin with less than a £1 balance' do
            expect{subject.touch_in("")}.to raise_error("Sorry. Insufficient funds. You need at least £#{Oystercard::MINIMUM} to travel.")
        end
    end

    it 'charges for the journey' do 
        subject.top_up(Oystercard::MAX_VALUE)
        expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM)
    end

    it 'testing a pending example' 
    # to be pending it must not open do end brackets, just have the it statement

    # by writing pending befor the block and this_should_not_get_executed as the last line, this block will return pending
    it 'is implemented but not finished' do
        pending expect(subject.touch_out).to eq(subject.in_journey)
        this_should_not_get_executed
    end

    # context 'test the logging of beginning of a journey' do
    #     # this did not define entry station as intended.
    #     # needed to pass station as argument 
    #     # let(:entry_station) {entry_station = "Liverpool Street"}

    #     it 'records the station where the journey started' do
    #         subject.top_up(Oystercard::MAX_VALUE)
    #         expect{ subject.touch_in("Liverpool Street") }.to change{subject.entry_station}.to("Liverpool Street")
    #     end
    # end

    context 'test the logging of beginning of a journey' do
        it 'records the station where the journey started' do
            subject.top_up(Oystercard::MAX_VALUE)
            expect{ subject.touch_in(station) }.to change{subject.entry_station}.to(station)
        end
    end


end