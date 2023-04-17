math.randomseed(os.time())

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

function get_difficulty()
  while true do
    io.write("Choose the difficulty level (1: Easy, 2: Normal, 3: Hard): ")
    local input = io.read()
    local num = tonumber(input)
    if num ~= nil and (num == 1 or num == 2 or num == 3) then
      return num
    end
    print("Invalid input, please enter a valid difficulty level (1, 2, or 3).")
  end
end

function get_game_mode()
  while true do
    io.write("Choose the game mode (1: Original, 2: Computer guesses, 3: Alternate): ")
    local input = io.read()
    local num = tonumber(input)
    if num ~= nil and (num == 1 or num == 2 or num == 3) then
      return num
    end
    print("Invalid input, please enter a valid game mode (1, 2, or 3).")
  end
end

function play_game(mode, difficulty)
  local max_range = 100
  if difficulty == 2 then
    max_range = 10000
  elseif difficulty == 3 then
    max_range = 1000000
  end

  if mode == 1 then
    return play_original_game(max_range)
  elseif mode == 2 then
    return play_computer_guesses_game(max_range)
  else
    return play_alternate_game(max_range)
  end
end

function play_original_game(max_range)
    print("Welcome to the computer guessing game!")
    local name = io.read("*l")
    print("Hello, " .. name .. "!")
  
    local answer = get_integer_input("Enter a number between 1 and " .. max_range .. " for the computer to guess: ")
    local num_guesses = 0
    local lower_bound = 1
    local upper_bound = max_range
  
    while true do
      local guess = math.random(lower_bound, upper_bound)
      num_guesses = num_guesses + 1
      print("Computer's guess: " .. guess)
  
      if guess == answer then
        print("Congratulations, the computer guessed your number in " .. num_guesses .. " tries!")
        return num_guesses
      elseif guess < answer then
        print("The number is higher than the computer's guess.")
        lower_bound = guess + 1
      else
        print("The number is lower than the computer's guess.")
        upper_bound = guess - 1
      end
    end
  end

function play_alternate_game(max_range)
  print("Welcome to the alternate number guessing game!")
  local name = io.read("*l")
  print("Hello, " .. name .. "!")

  local answer_player = math.random(1, max_range)
  local answer_computer = math.random(1, max_range)
  local num_guesses_player = 0
  local num_guesses_computer = 0
  local lower_bound = 1
  local upper_bound = max_range
  local winner = nil

  while winner == nil do
    -- Player's turn
    local guess_player = get_integer_input(name .. ", guess a number between 1 and " .. max_range .. ": ")
    num_guesses_player = num_guesses_player + 1

    if guess_player == answer_player then
      winner = "player"
    elseif guess_player < answer_player then
      print("The number is higher than your guess.")
    else
      print("The number is lower than your guess.")
    end

    if winner ~= nil then break end

    -- Computer's turn
    local guess_computer = math.random(lower_bound, upper_bound)
    num_guesses_computer = num_guesses_computer + 1
    print("Computer's guess: " .. guess_computer)

    if guess_computer == answer_computer then
      winner = "computer"
    elseif guess_computer < answer_computer then
      print("The number is higher than the computer's guess.")
      lower_bound = guess_computer + 1
    else
      print("The number is lower than the computer's guess.")
      upper_bound = guess_computer - 1
    end
  end

  if winner == "player" then
    print(name .. " wins! You guessed the number in " .. num_guesses_player .. " tries!")
  else
    print("Computer wins! The computer guessed the number in " .. num_guesses_computer .. " tries!")
  end

  return num_guesses_player + num_guesses_computer
end

function display_statistics_and_rankings(num_games, total_guesses, best_score, rankings)
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

function main()
    local num_games = 0
    local total_guesses = 0
    local best_score = math.huge
    local rankings = {}
    
    print("Would you like to play a game? (y/n)")
    local play_again = io.read("*l")
    
    while play_again == "y" do
      local difficulty = get_difficulty()
      local mode = get_game_mode()
      
      num_games = num_games + 1
      local num_guesses = play_game(mode, difficulty)
      total_guesses = total_guesses + num_guesses
      if num_guesses < best_score then
        best_score = num_guesses
      end
      table.insert(rankings, {num_games, num_guesses})
      
      print("Would you like to play again? (y/n)")
      play_again = io.read("*l")
    end
  
    display_statistics_and_rankings(num_games, total_guesses, best_score, rankings)
  end

main()