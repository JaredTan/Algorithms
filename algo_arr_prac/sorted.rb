Given a sorted array consisting of only integer where every element appears twice except for one element which appears once. Find this single element that appears only once. Do it in O(log n) time and O(1) space



def search(arr)
  return arr[0] if arr.length == 1
  half = arr.length / 2
  if arr[half] != arr[half-1] && arr[half] != arr[half + 1]
    return arr[half]
  elsif arr[half - 1] == arr[half]
    search(arr[0..(half - 1)])
  else
    search(arr[(half + 1)...arr.length])
  end
end



binary_search([1, 1, 4, 7, 7, 10, 10, 15, 15, 19, 19])

[1, 1, 4, 7, 7]  [10, 10, 15, 15]

[1, 1, 4, 4, 7, 7, 10, 15, 15]

[1, 1, 4, 4, 7] [7, 10, 15, 15]


([]){()} is good

def well_formed_string(string)

end
