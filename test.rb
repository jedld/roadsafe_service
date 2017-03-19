# 173 Epifanio de los Santos Ave
# Mandaluyong, 1555 Metro Manila
# 14.589813, 121.057282

lat = 14.589813
lng = 121.057282

result = (0..24).collect { |h|
  count = Incident.within(0.5, :origin => [lat,lng]).where(hour_of_day: h).count

  h = if (h + 8 > 23)
    h = h + 8 - 24
  else
    h + 8
  end

  [h, count]
}
result.each do |r|
  puts "#{r[1]}"
end


8 9
9 9
10 18
11 17
12 21
13 13
14 23
15 16
16 19
17 9
18 13
19 15
20 16
21 11
22 16
23 6
0 3
1 5
2 1
3 2
4 9
5 5
6 5
7 14
8 0
