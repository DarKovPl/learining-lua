
math.randomseed(os.time())

function add_player(players)
  print("Enter player name:")
  local name = io.read("*l")
  table.insert(players, {name=name, score=0, is_leader=false})
end

function get_range(difficulty)
  local min_range, max_range
  if difficulty == 1 then
    min_range, max_range = 1, 100
  elseif difficulty == 2 then
    min_range, max_range = 1, 10000
  else
    min_range, max_range = 1, 1000000
  end

  print("Enter minimum range (" .. min_range .. " - " .. max_range .. "):")
  local min_input = tonumber(io.read("*l"))
  print("Enter maximum range (" .. min_range .. " - " .. max_range .. "):")
  local max_input = tonumber(io.read("*l"))

  if min_input ~= nil and max_input ~= nil and min_input >= min_range and max_input <= max_range then
    return min_input, max_input
  end

  print("Invalid input. Using default range.")
  return min_range, max_range
end

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
    io.write("Choose the game mode (1: Original, 2: Computer guesses, 3: Mix game): ")
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
    return play_mix_game(max_range)
  end
end

function play_original_game(max_range)
  print("Welcome to the player guessing game! Enter name:")
  local name = io.read("*l")
  print("Hello, " .. name .. "!")
  
  local answer = math.random(1, max_range)
  local num_guesses = 0
  
  while true do
    local guess = get_integer_input(name .. ", guess a number between 1 and " .. max_range .. ": ")
    num_guesses = num_guesses + 1
  
    if guess == answer then
      print("Congratulations, " .. name .. "! You guessed the number in " .. num_guesses .. " tries!")
      return num_guesses
    elseif guess < answer then
      print("The number is higher than your guess.")
    else
      print("The number is lower than your guess.")
    end
  end
end

function play_computer_guesses_game(max_range)
    print("Welcome to the computer guessing game! Enter name:")
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

function play_mix_game(min_range, max_range, players)
    print("Welcome to the alternate number guessing game!")
    for i, player in ipairs(players) do
      print("Hello, " .. player.name .. "!")
    end
  
    local answer_player = {}
    local num_guesses_player = {}
    for i, player in ipairs(players) do
      answer_player[player.name] = math.random(min_range, max_range)
      num_guesses_player[player.name] = 0
    end
  
    local answer_computer = math.random(min_range, max_range)
    local num_guesses_computer = 0
    local lower_bound = min_range
    local upper_bound = max_range
    local winner = nil
  
    while winner == nil do
      for i, player in ipairs(players) do
        -- Player's turn
        local guess_player = get_integer_input(player.name .. ", guess a number between " .. min_range .. " and " .. max_range .. ": ")
        num_guesses_player[player.name] = num_guesses_player[player.name] + 1
  
        if guess_player == answer_player[player.name] then
          winner = player.name
          print(player.name .. " wins! You guessed the number in " .. num_guesses_player[player.name] .. " tries!")
          break
        elseif guess_player < answer_player[player.name] then
          print("The number is higher than your guess.")
        else
          print("The number is lower than your guess.")
        end
      end
  
      if winner ~= nil then break end
  
      -- Computer's turn
      local guess_computer = math.random(lower_bound, upper_bound)
      num_guesses_computer = num_guesses_computer + 1
      print("Computer's guess: " .. guess_computer)
  
      if guess_computer == answer_computer then
        winner = "computer"
        print("Computer wins! The computer guessed the number in " .. num_guesses_computer .. " tries!")
        break
      elseif guess_computer < answer_computer then
        print("The number is higher than the computer's guess.")
        lower_bound = guess_computer + 1
      else
        print("The number is lower than the computer's guess.")
        upper_bound = guess_computer - 1
      end
    end
  
    return num_guesses_player, num_guesses_computer
  end

function display_statistics_and_rankings(num_games, total_guesses, best_score, rankings)
    print("Thanks for playing!")
    print("Total games played: " .. num_games)
    print("Average number of guesses per game: " .. total_guesses / num_games)
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
      local star = ""
      if i == 1 then
        star = "★"
      end
      print(game_num .. suffix .. " game: " .. num_guesses .. " guesses" .. star)
    end
end

function main()
    local num_games = 0
    local total_guesses = 0
    local best_score = math.huge
    local rankings = {}
    
    print("Enter the number of players:")
    local num_players = tonumber(io.read())
    local players = {}
    
    for i = 1, num_players do
      print("Enter the name of player " .. i .. ":")
      local player_name = io.read()
      table.insert(players, {name = player_name})
    end
    
    print("Would you like to play a game? (y/n)")
    local play_again = io.read("*l")
    
    while play_again == "y" do
      local difficulty = get_difficulty()
      local mode = get_game_mode()
      
      num_games = num_games + 1
      local min_range, max_range = get_range()
      local num_guesses_players, num_guesses_computer = play_mix_game(min_range, max_range, players)
      local total_game_guesses = num_guesses_computer
      for _, num_guesses in pairs(num_guesses_players) do
        total_game_guesses = total_game_guesses + num_guesses
      end
      total_guesses = total_guesses + total_game_guesses
      
      if total_game_guesses < best_score then
        best_score = total_game_guesses
      end
      table.insert(rankings, {num_games, total_game_guesses})
      
      print("Would you like to play again? (y/n)")
      play_again = io.read("*l")
    end
  
    display_statistics_and_rankings(num_games, total_guesses, best_score, rankings)
  end
  
main()