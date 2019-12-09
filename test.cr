my_typle = {0, 2}
case {my_typle.first, my_typle.last}
when {0, _}
  # Matches if 0 === value1, no test done against value2
when {_, 0}
  # Matches if 0 === value2, no test done against value1
end