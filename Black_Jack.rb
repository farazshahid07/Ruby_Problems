
$suit = ["Spades", "Hearts", "Clubs", "Diamonds"]
$card = ["Two", "Three", "Four", "Five" ,"Six" , "Seven", "Eight", "Nine", "Ten", "Ace", "King", "Queen", "Jack"]
$value = {"Two"=>2, "Three"=>3, "Four"=>4, "Five"=>5 ,"Six"=>6 , "Seven"=>7, "Eight"=>8, "Nine"=>9, "Ten"=>10, "Ace"=>11, "King"=>10, "Queen"=>10, "Jack"=>10}
$player_total = 0
$dealer_total = 0
$p_hand = []
$d_hand = []
# $bool_ace = true
# $i = 0
bool = true

class BlackJack

  attr_accessor:bet
  def initialize(bet)
    @bet = bet
  end

  def dealer_hand

    card_1 = $card[rand($card.length)]
    card_2 = $card[rand($card.length)]

    puts "Dealer's Hand:"

    $d_hand <<  "\n#{card_1} of #{$suit[rand($suit.length)]}"
    $d_hand <<  "#{card_2} of #{$suit[rand($suit.length)]}"

    puts "\n< card hidden >"
    puts $d_hand[1]

    $value.fetch(card_1) + $value.fetch(card_2)
  end

  def player_hand

    card_1 = $card[rand($card.length)]
    card_2 = $card[rand($card.length)]

    puts "\nPlayer's Hand:"

    $p_hand <<  "\n#{card_1} of #{$suit[rand($suit.length)]}"
    $p_hand <<  "#{card_2} of #{$suit[rand($suit.length)]}"

    puts $p_hand

    $value.fetch(card_1) + $value.fetch(card_2)
  end

  def hit

    card_x = $card[rand($card.length)]

    $p_hand <<  "#{card_x} of #{$suit[rand($suit.length)]}"
    puts "\nPlayer's Hand:"
    puts $p_hand
    puts $p_hand.length

    if $p_hand.length == 3
      ($p_hand.length).times do |i|

        if $p_hand[i].include? "Ace"

          if ($player_total+$value.fetch(card_x)) > 21
            $bool_ace=true

            return ($value.fetch(card_x) - 10)
          end
          @flag = 1
        end
      end
    end

    if $bool_ace==false
      if ($player_total+$value.fetch(card_x)) > 21 && $value.fetch(card_x) == 11
        return ($value.fetch(card_x) - 10)
      elsif ($player_total+$value.fetch(card_x)) > 21 && @flag == 1
        return ($value.fetch(card_x) - 10)
      end
    end

    if ($player_total + $value.fetch(card_x)) > 21
      puts "\nBusted"
    end

    $value.fetch(card_x)
  end




  def stand

    if $dealer_total > $player_total

      puts "\nDealer's Hand:"
      puts $d_hand
      return $dealer_total

    elsif $dealer_total <= $player_total

      a = 0
      while ($dealer_total <= $player_total) && (a<3)
        ace=false
        card_x = $card[rand($card.length)]

        $d_hand << "#{card_x} of #{$suit[rand($suit.length)]}"
        puts "\nDealer's Hand:"
        puts $d_hand

        if a == 0
          ($d_hand.length).times do |i|

            if $d_hand[i].include? "Ace"

              if ($dealer_total+$value.fetch(card_x)) > 21
                $dealer_total -= 10
                $dealer_total += $value.fetch(card_x)
                ace=true
              end
            end
          end
        end

        if ace==false
          if $value.fetch(card_x) == 11
            $dealer_total -= 10
            $dealer_total += $value.fetch(card_x)
          else
            $dealer_total += $value.fetch(card_x)
          end
        end

        a+=1
      end

      return $dealer_total

    end

  end



  def win_lose
    if ($player_total > $dealer_total) && ($player_total <= 21)
      puts "\nYou Win"
    elsif ($player_total > $dealer_total) && ($player_total > 21)
      puts "\nYou Lose"
    elsif ($dealer_total > $player_total) && ($dealer_total <= 21)
      puts "\nYou Lose"
    elsif ($dealer_total > $player_total) && ($dealer_total > 21)
      puts "\nYou Win"
    end
  end

end

obj = BlackJack.new(60)

$dealer_total += obj.dealer_hand

puts "\nPlayer's Total: #{$player_total += obj.player_hand}"


while bool==true
  puts "\nWould you like to hit or stand? Enter 'h' or 's'"
  ch = gets

  if ch.chomp=='h'
    $bool_ace = false
    puts "\nPlayer's Total: #{$player_total += obj.hit}"
    if ($player_total > 21)
      bool = false
    end

  elsif ch.chomp=='s'

    puts "\nDealer's Total: #{$dealer_total = obj.stand}"
    bool = false

  else
    puts "Wrong choice. Enter 'h' or 's'"
  end
end

obj.win_lose

puts "\nThanks for playing."
