
def Pass_Generator(arr , n)
  pwd = []
  n.times do |i| pwd[i] = arr[rand(arr.length)] end
  pwd
end

arr = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a + ('!'..'/').to_a

print ("Enter password length: ")
len = gets.to_i

puts "Your Password is: #{Pass_Generator(arr,len).join('')}"
