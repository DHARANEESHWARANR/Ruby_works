# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
    hash = {}
   index = 0
    nums.each do |element|
       pair_value = target - element
        if hash.key?(pair_value)
          result_array = []
          result_array << hash[pair_value] 
          result_array << index 
          return result_array
        else
          hash[element] = index
        end
       index+=1
    end
end