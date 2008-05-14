
module BakeryDate
  
  def self.timestamp_parts(day, time = '')
	  if time.match(/(\d{1,2})(am|pm)/i) then time = "#{$1}:00 #{$2}" end
	  parts = ParseDate.parsedate("#{day} #{time}")
	  parts[0] = Time.now.strftime("%Y") if not parts[0]
	  #puts parts.to_yaml
	  parts
  end

	def self.timestamp(day, time='')
		#parts = self.timestamp_parts(day, time)
		#funny hack, convert to type and then to db format, so all 00 set
		#{}"#{parts[0]}-#{parts[1]}-#{parts[2]} #{parts[3]}:#{parts[4]}:#{parts[5]}".to_time.to_s(:db)
	  return Time.parse("#{day} #{time}").to_s(:db)
	
end
	
    
end