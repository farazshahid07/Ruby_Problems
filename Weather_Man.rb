
class WeatherMan

  def reader(file_data,file_names,columns)

    (file_names.length).times do |name|

      row = []
      File.foreach("/home/faraz/Desktop/Ruby/Weather man/#{file_names[name]}") do |line|
        hash = Hash.new

        columns.each do |i|
          hash.store(i,"")
        end

        row = line.chomp.split(',')

        row.each_with_index do |item,index|

          keys = hash.keys

          hash[keys[index]] = item
        end

        file_data << hash
      end

    end

  end

##########################################################

  def max_temp(file_data, year, months)

    puts "Year: #{year}"

    max=0
    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if row["Max TemperatureC"].to_i > max && @date[0].to_i == year
        max = row["Max TemperatureC"].to_i
        @d = @date[2]
        @month = months[(@date[1].to_i)-1]
      end

    end

    puts "Highest : #{max}C on #{@month} #{@d}"
  end

  def min_temp(file_data, year, months)
    min=100
    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if row["Min TemperatureC"].to_i < min && @date[0].to_i == year
        min = row["Min TemperatureC"].to_i
        @d = @date[2]
        @month = months[(@date[1].to_i)-1]
      end

    end

    puts "Lowest : #{min}C on #{@month} #{@d}"
  end

  def max_humid(file_data, year, months)
    max=0
    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if row["Max Humidity"].to_i > max && @date[0].to_i == year
        max = row["Max Humidity"].to_i
        @d = @date[2]
        @month = months[(@date[1].to_i)-1]
      end

    end

    puts "Humid : #{max}% on #{@month} #{@d}"
  end

###########################################################

  def max_avg_temp(file_data, year, months , s_month)

    puts "Year: #{year}"

    max=0
    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if row["Mean TemperatureC"].to_i > max && @date[0].to_i == year && @date[1].to_i == s_month
        max = row["Mean TemperatureC"].to_i
        @d = @date[2].to_i
        @month = months[(@date[1].to_i)-1]
      end

    end

    puts "Highest Average : #{max}C on #{@month} #{@d}"
  end

  def min_avg_temp(file_data, year, months, s_month)
    min=100
    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if row["Mean TemperatureC"].to_i < min && @date[0].to_i == year && @date[1].to_i == s_month
        min = row["Mean TemperatureC"].to_i
        @d = @date[2].to_i
        @month = months[(@date[1].to_i)-1]
      end

    end

    puts "Lowest Average : #{min}C on #{@month} #{@d}"
  end

  def avg_humid(file_data, year, months, s_month)
    max=0
    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if row[" Mean Humidity"].to_i > max && @date[0].to_i == year && @date[1].to_i == s_month
        max = row[" Mean Humidity"].to_i
        @d = @date[2].to_i
        @month = months[(@date[1].to_i)-1]
      end
    end

    puts "Average Humid : #{max}C on #{@month} #{@d}"
  end

##########################################################

  def s_chart(file_data, year, months, s_month)

    max=0
    min=100
    i=0

    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if @date[0].to_i == year && @date[1].to_i == s_month && i<30

        @month = months[(@date[1].to_i)-1]
        if i==0
          puts "#{@month} #{@date[0]}"
        end

        max = row["Max TemperatureC"].to_i
        @d = @date[2].to_i
        print "#{@d}"
        max.times do print "+" end
        print " #{max}C"
        puts

        min = row["Min TemperatureC"].to_i
        print "#{@d}"
        min.times do print "-" end
        print " #{min}C"
        puts

        i+=1
      end
    end
  end

  def d_chart(file_data, year, months, s_month)

    max=0
    min=100
    i=0

    file_data.each do |row|

      @date = row["TimeZone"].split('-')

      if @date[0].to_i == year && @date[1].to_i == s_month && i<30

        @month = months[(@date[1].to_i)-1]
        if i==0
          puts "#{@month} #{@date[0]}"
        end

        max = row["Max TemperatureC"].to_i
        min = row["Min TemperatureC"].to_i
        @d = @date[2].to_i

        print "#{@d}"
        min.times do print "-" end
        max.times do print "+" end
        print " #{min}C - #{max}C"
        puts

        i+=1
      end
    end
  end


end


file = File.open("/home/faraz/Desktop/Ruby/Weather man/Dubai_weather_2005_Aug.txt")

file_data = []
columns = file.readline.chomp.split(',')
columns[0] = "TimeZone"


file_names =  Dir.chdir("/home/faraz/Desktop/Ruby/Weather man") { Dir.entries(".") }
file_names.delete_at(0)
file_names.delete_at(0)

w_obj = WeatherMan.new

w_obj.reader(file_data, file_names, columns)
file_data.delete_at(0)

months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

unless ARGV[1].include?("/")
  choice = ARGV[0]
  year = ARGV[1].to_i
end
if ARGV[1].include?("/")
  choice = ARGV[0]
  split = ARGV[1].split('/')
  year = split[0].to_i
  s_month = split[1].to_i
end

if choice=="-e"
  puts
  w_obj.max_temp(file_data, year, months)
  w_obj.min_temp(file_data, year, months)
  w_obj.max_humid(file_data, year, months)
  puts
elsif choice=="-a"
  puts
  w_obj.max_avg_temp(file_data, year, months, s_month)
  w_obj.min_avg_temp(file_data, year, months, s_month)
  w_obj.avg_humid(file_data, year, months, s_month)
  puts
elsif choice=="-c"
  puts
  w_obj.s_chart(file_data, year, months, s_month)
  puts
  w_obj.d_chart(file_data, year, months, s_month)
  puts
else
  puts "Wrong Choice."
end
