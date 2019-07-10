class BattleSummary

  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def computer_summary
     puts '-' * 50
     if @computer.cruiser.sunk? == false && @computer.submarine.sunk? == false
       puts "Computer => #{@computer.cruiser.name} Health: #{@computer.cruiser.health} #{@computer.submarine.name} Health: #{@computer.submarine.health}"
     elsif @computer.cruiser.sunk? == true && @computer.submarine.sunk? == false
       puts "Computer => #{@computer.cruiser.name} DESTROYED! #{@computer.submarine.name} Health: #{@computer.submarine.health}"
     elsif @computer.cruiser.sunk? == false && @computer.submarine.sunk? == true
       puts "Computer => #{@computer.cruiser.name} Health: #{@computer.cruiser.health} #{@computer.submarine.name} DESTROYED!"
     else
       puts "Computer => #{@computer.cruiser.name} DESTORYED! #{@computer.submarine.name} DESTROYED!"
     end
     puts '==================COMPUTER BOARD=================='
  end

  def user_summary
    puts '-' * 50
    if @user.cruiser.sunk? == false && @user.submarine.sunk? == false
      puts "User => #{@user.cruiser.name} Health: #{@user.cruiser.health} #{@user.submarine.name} Health: #{@user.submarine.health}"
    elsif @user.cruiser.sunk? == true && @user.submarine.sunk? == false
      puts "User => #{@user.cruiser.name} DESTROYED! #{@user.submarine.name} Health: #{@user.submarine.health}"
    elsif @user.cruiser.sunk? == false && @user.submarine.sunk? == true
      puts "User => #{@user.cruiser.name} Health: #{@user.cruiser.health} #{@user.submarine.name} DESTROYED!"
    else
      puts "User => #{@user.cruiser.name} DESTORYED! #{@user.submarine.name} DESTROYED!"
    end
    puts '====================PLAYER BOARD==================='
  end

end
