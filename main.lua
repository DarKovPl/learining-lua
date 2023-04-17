--[[
local imie
io.write("Podaj Imii©")
imie = io.read()
print('Jestem',imie)



local imie
local wiek
io.write("Podaj Imi©\n")
imie = io.read()
io.write("Podaj Wiek\n")
wiek = tonumber(io.read())
print('Jestem',imie)
print('Mam lat:',wiek)

]]--

-- local wiek
-- io.write("Podaj Wiek\n")
-- wiek = tonumber(io.read())

-- if(wiek<=10)then
--     io.write("Jeste˜ mˆody\n")
-- elseif (wiek>10 and wiek<60)then
--     io.write("Jeste˜ ˜redni wiekiem\n")
-- else
--     io.write("Jeste˜ stary\n")
-- end

-- for i = 1, 10 do
--     print(i)
-- end



-- Welcome message and prompt for user input
io.write("Welcome! What's your name? ")
local name = io.read()
print("Hi " .. name .. "! Let's perform some matrix operations.")

-- List of possible operations
local operations = {"add", "subtract", "multiply", "exit"}


function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- Prompt for operation selection
local operation
repeat
    print("Select an operation: add, subtract, multiply, or exit")
    operation = io.read()
until table.contains(operations, operation)

-- Prompt for matrix dimensions
print("Enter the dimensions of the matrices (e.g. '3x3')")
local dimensions = io.read()
local rows, cols = dimensions:match("(%d+)x(%d+)")
rows, cols = tonumber(rows), tonumber(cols)

-- Prompt for values to fill matrices
print("Enter a value to fill the first matrix")
local a = tonumber(io.read())
print("Enter a value to fill the second matrix")
local b = tonumber(io.read())

-- Create matrices and fill with values
local matrixA = {}
local matrixB = {}
for i = 1, rows do
    matrixA[i] = {}
    matrixB[i] = {}
    for j = 1, cols do
        matrixA[i][j] = a
        matrixB[i][j] = b
    end
end

-- Perform operation and display result
local result
if operation == "add" then
    result = matrixAdd(matrixA, matrixB)
elseif operation == "subtract" then
    result = matrixSubtract(matrixA, matrixB)
elseif operation == "multiply" then
    result = matrixMultiply(matrixA, matrixB)
else
    os.exit()
end
print("Result:")
matrixPrint(result)

-- Prompt for next operation or exit
local choice
repeat
    print("Enter 'c' to perform another operation or 'x' to exit")
    choice = io.read()
until choice == "c" or choice == "x"

if choice == "c" then
    os.execute("clear") -- clear terminal for better user experience
    dofile("matrix_operations.lua") -- restart the program
else
    os.exit()
end

-- Matrix addition function
function matrixAdd(a, b)
    local rows, cols = #a, #a[1]
    local result = {}
    for i = 1, rows do
        result[i] = {}
        for j = 1, cols do
            result[i][j] = a[i][j] + b[i][j]
        end
    end
    return result
end

-- Matrix subtraction function
function matrixSubtract(a, b)
    local rows, cols = #a, #a[1]
    local result = {}
    for i = 1, rows do
        result[i] = {}
        for j = 1, cols do
            result[i][j] = a[i][j] - b[i][j]
        end
    end
    return result
end

-- Matrix multiplication function
function matrixMultiply(a, b)
    local rowsA, colsA = #a, #a[1]
    local rowsB, colsB = #b, #b[1]
    local result = {}
    for i = 1, rowsA do
        result[i] = {}
        for j = 1, colsB do
            local sum = 0
            for k = 1, colsA do
                sum = sum + a[i][k] * b[k][j]
            end
            result[i][j] = sum
        end
    end
end