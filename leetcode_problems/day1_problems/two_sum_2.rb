# @param {Integer[]} numbers
# @param {Integer} target
# @return {Integer[]}
def two_sum(nums, target)
   hash = {}
   index = 0
    nums.each do |element|
       val = target - element
        if hash.key?(val)
          result = []
          result << hash[val] + 1
          result << index + 1
          return result
        else
          hash[element] = index
        end
       index+=1
    end

end