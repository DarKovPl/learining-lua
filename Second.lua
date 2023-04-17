-- greet user and ask for name
print("Hello, what's your name?")
local name = io.read()

-- display menu and ask for user choice
print("Hi " .. name .. "! Here are the available operations:")
print("1. Add two matrices")
print("2. Subtract two matrices")
print("3. Multiply two matrices")
print("4. Transpose a matrix")
print("5. Exit program")

local choice
repeat
  print("Please enter the number of the operation you want to perform:")
  choice = tonumber(io.read())
until choice and choice >= 1 and choice <= 5

-- exit program if user chooses option 5
if choice == 5 then
  print("Goodbye!")
  os.exit()
end

-- ask for matrix dimensions
print("What is the dimension of the matrices?")
local dimension = tonumber(io.read())

-- ask for values to fill first matrix
print("Please enter a value to fill the first matrix:")
local value1 = tonumber(io.read())

-- create first matrix filled with the user's value
local matrix1 = {}
for i = 1, dimension do
  matrix1[i] = {}
  for j = 1, dimension do
    matrix1[i][j] = value1
  end
end

-- ask for values to fill second matrix
print("Please enter a value to fill the second matrix:")
local value2 = tonumber(io.read())

-- create second matrix filled with the user's value
local matrix2 = {}
for i = 1, dimension do
  matrix2[i] = {}
  for j = 1, dimension do
    matrix2[i][j] = value2
  end
end

-- perform selected operation on matrices
local result
if choice == 1 then
  -- add matrices
  result = {}
  for i = 1, dimension do
    result[i] = {}
    for j = 1, dimension do
      result[i][j] = matrix1[i][j] + matrix2[i][j]
    end
  end
elseif choice == 2 then
  -- subtract matrices
  result = {}
  for i = 1, dimension do
    result[i] = {}
    for j = 1, dimension do
      result[i][j] = matrix1[i][j] - matrix2[i][j]
    end
  end
elseif choice == 3 then
  -- multiply matrices
  result = {}
  for i = 1, dimension do
    result[i] = {}
    for j = 1, dimension do
      result[i][j] = 0
      for k = 1, dimension do
        result[i][j] = result[i][j] + matrix1[i][k] * matrix2[k][j]
      end
    end
  end
elseif choice == 4 then
  -- transpose matrix
  result = {}
  for i = 1, dimension do
    result[i] = {}
    for j = 1, dimension do
      result[i][j] = matrix1[j][i]
    end
  end
end

-- display result
print("Result:")
for i = 1, dimension do
  for j = 1, dimension do
    io.write(result[i][j] .. " ")
  end
  print()
end

-- ask if user wants to perform another operation
print("Do you want to perform another operation? (Y/N)")
local answer = io.read()
if answer:lower() == "n" then
  print("Goodbye!")
  os.exit()
end