require 'colorize'

class BattleSummary

  def initialize(computer, user)
    @computer = computer
    @user = user
  end

  def computer_summary
     puts '-'.yellow * 50
     if @computer.cruiser.sunk? == false && @computer.submarine.sunk? == false
       puts "Computer =>".yellow + " #{@computer.cruiser.name} Health:".green + " #{@computer.cruiser.health}" + " #{@computer.submarine.name} Health:".green + " #{@computer.submarine.health}"
     elsif @computer.cruiser.sunk? == true && @computer.submarine.sunk? == false
       puts "Computer =>".yellow + " #{@computer.cruiser.name}".red + " \u{2620} ".blink + " #{@computer.submarine.name} Health:".green + " #{@computer.submarine.health}"
     elsif @computer.cruiser.sunk? == false && @computer.submarine.sunk? == true
       puts "Computer =>".yellow + " #{@computer.cruiser.name} Health:".green + " #{@computer.cruiser.health}" + " #{@computer.submarine.name}".red + " \u{2620} ".blink
     else
       puts "Computer =>".yellow + " #{@computer.cruiser.name}".red  + " \u{2620} ".blink + " #{@computer.submarine.name}".red  + " \u{2620} ".blink
     end
     puts '==================COMPUTER BOARD=================='.yellow
  end

  def user_summary
    puts '-'.light_blue * 50
    if @user.cruiser.sunk? == false && @user.submarine.sunk? == false
      puts "Player =>".light_blue + " #{@user.cruiser.name} Health:".green + " #{@user.cruiser.health}" + " #{@user.submarine.name} Health:".green + " #{@user.submarine.health}"
    elsif @user.cruiser.sunk? == true && @user.submarine.sunk? == false
      puts "Player =>".light_blue + " #{@user.cruiser.name}".red + " \u{2620} ".blink + " #{@user.submarine.name} Health:".green + " #{@user.submarine.health}"
    elsif @user.cruiser.sunk? == false && @user.submarine.sunk? == true
      puts "Player =>".light_blue + " #{@user.cruiser.name} Health:".green + " #{@user.cruiser.health}" + " #{@user.submarine.name}".red + " \u{2620} ".blink
    else
      puts "Player =>".light_blue + " #{@user.cruiser.name}".red  + " \u{2620} ".blink + " #{@user.submarine.name}".red  + " \u{2620} ".blink
    end
    puts '====================PLAYER BOARD=================='.light_blue
  end
end
