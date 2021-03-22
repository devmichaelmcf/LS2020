def pick_peaks(input_arr)
  peak = []
  position = []
  
  current_value = nil
  current_index = 1
  
  loop do
      current_value = input_arr[current_index]
       if input_arr[current_index - 1] < current_value && input_arr[(current_index + 1)..-2].any? {|num| current_value > num }
         peak << current_value 
       end
      current_index += 1
      break if current_index >= input_arr.length
  end
  peak
end


# 'should support finding peaks') do
p pick_peaks([1,2,3,6,4,1,2,3,2,1])#, {"pos"=>[3,7], "peaks"=>[6,3]})

# #should support finding peaks, but should ignore peaks on the edge of the array') do
# p pick_peaks([3,2,3,6,4,1,2,3,2,1,2,3])#, {"pos"=>[3,7], "peaks"=>[6,3]})
# #'should support finding peaks; if the peak is a plateau, it should only return the position of the first element of the plateau')
# p pick_peaks([3,2,3,6,4,1,2,3,2,1,2,2,2,1])#, {"pos"=>[3,7,10], "peaks"=>[6,3,2]})
# # 'should support finding peaks; if the peak is a plateau, it should only return the position of the first element of the plateau') 
# p pick_peaks([2,1,3,1,2,2,2,2,1])#, {"pos"=>[2,4], "peaks"=>[3,2]})
# #'should support finding peaks, but should ignore peaks on the edge of the array') do
# p pick_peaks([2,1,3,1,2,2,2,2])#, {"pos"=>[2], "peaks"=>[3]})
