io.write("Enter your name: ")
local name = io.read()

print("Hello, "..name.."!")

function matrix_multiply(matrix1, matrix2)
  local result_matrix = {}
  for i=1,#matrix1 do
      local row = {}
      for j=1,#matrix2[1] do
          local sum = 0
          for k=1,#matrix2 do
              sum = sum + matrix1[i][k] * matrix2[k][j]
          end
          table.insert(row, sum)
      end
      table.insert(result_matrix, row)
  end
  return result_matrix
end

function print_matrix(matrix)
  for i=1,#matrix do
      for j=1,#matrix[i] do
          io.write(matrix[i][j].." ")
      end
      io.write("\n")
  end
end

while true do
  print("Choose an operation:")
  print("1 Matrix multiplication")
  print("0 Exit")

  -- Get user input for operation choice
  io.write("Operation: ")
  local operation = tonumber(io.read())

  if operation == 0 then
      print("Goodbye, "..name.."!")
      break
  end

  io.write("Enter the dimension of the matrices: ")
  local dim = tonumber(io.read())

  io.write("Enter the value for the first matrix: ")
  local value1 = tonumber(io.read())

  local matrix1 = {}
  for i=1,dim do
      local row = {}
      for j=1,dim do
          table.insert(row, value1)
      end
      table.insert(matrix1, row)
  end

  print("First matrix:")
  print_matrix(matrix1)

  io.write("Enter the value for the second matrix: ")
  local value2 = tonumber(io.read())

  local matrix2 = {}
  for i=1,dim do
      local row = {}
      for j=1,dim do
          table.insert(row, value2)
      end
      table.insert(matrix2, row)
  end

  print("Second matrix:")
  print_matrix(matrix2)

  local result_matrix = matrix_multiply(matrix1, matrix2)

  print("Result matrix:")
  print_matrix(result_matrix)
end