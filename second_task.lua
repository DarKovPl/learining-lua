math.randomseed(os.time()) -- initialize random number generator

-- Function to get user input as integer
function get_integer_input(prompt)
  while true do
    io.write(prompt)
    local input = io.read()
    local num = tonumber(input)
    if num ~= nil and math.floor(num) == num then
      return num
    end
    print("Invalid input, please enter an integer.")
  end
end

-- Function to play one round of the game
function play_game()
  print("Welcome to the number guessing game!")
  local name = io.read("*l")
  print("Hello, " .. name .. "!")
  
  local answer = math.random(1, 100)
  local num_guesses = 0
  
  while true do
    local guess = get_integer_input("Guess a number between 1 and 100: ")
    num_guesses = num_guesses + 1
    
    if guess == answer then
      print("Congratulations, you guessed the number in " .. num_guesses .. " tries!")
      return num_guesses
    elseif guess < answer then
      print("The number is higher than your guess.")
    else
      print("The number is lower than your guess.")
    end
  end
end

-- Main function to run the game
function main()
  local num_games = 0
  local total_guesses = 0
  local best_score = math.huge
  local rankings = {}
  
  print("Would you like to play a game? (y/n)")
  local play_again = io.read("*l")
  
  while play_again == "y" do
    num_games = num_games + 1
    local num_guesses = play_game()
    total_guesses = total_guesses + num_guesses
    if num_guesses < best_score then
      best_score = num_guesses
    end
    table.insert(rankings, {num_games, num_guesses})
    
    print("Would you like to play again? (y/n)")
    play_again = io.read("*l")
  end
  
  print("Thanks for playing!")
  print("Total games played: " .. num_games)
  print("Average number of guesses per game: " .. total_guesses/num_games)
  print("Best score: " .. best_score)
  
  table.sort(rankings, function(a, b) return a[2] < b[2] end)
  print("Rankings:")
  for i, v in ipairs(rankings) do
    local game_num, num_guesses = v[1], v[2]
    local suffix = "th"
    if i == 1 then
      suffix = "st"
    elseif i == 2 then
      suffix = "nd"
    elseif i == 3 then
      suffix = "rd"
    end
    print(game_num .. suffix .. " game: " .. num_guesses .. " guesses")
  end
end

main()
