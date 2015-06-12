   
   require 'net/http'  
   def collect(number,string)
   	url = URI.parse("http://172.16.18.230:8080/api/sector/6/#{string}")
   	req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
   }
    arr1=res.body
  return arr1=arr1.split("\n")
  puts res.code
end
 rgarr=Array.new
 rgarr2=Array.new
 rootarr=Array.new
 rootarr2=Array.new
 arr1=nil
 arr2=nil
 10.times do |count|
  arr1=collect(count,"objects")
  arr2=collect(count,"roots")
 arr1.each do |allobjects|
 	arr2.each do |root|
 	  if(allobjects.split("\s").first==root)
			rootarr<<allobjects.split("\s").first
			 rootarr<<allobjects.split("\s").last
   		end	
   	    if(allobjects.split("\s").last==root)
			#rootarr<<allobjects.split("\s").first
			 rootarr<<allobjects.split("\s").last
 		  end
 	end	
   rootarr.each do |haha|
   	  if(haha==allobjects.split("\s").first)
         root=allobjects.split("\s").first
         rootarr2<<root
       end 
   	  if(haha==allobjects.split("\s").last)
         root=allobjects.split("\s").first
         rootarr2<<root
       end  
   end
end
 rootarr=rootarr+rootarr2
  rootarr.uniq
  arr1.each do |haha1|
  	if(((rootarr.include?haha1.split("\s").first)==false) && ((rootarr.include?haha1.split("\s").last)==false))
  		rgarr<<haha1
  	end
  end	

   rgarr2=rgarr	
 	rgarr.each do |haha2|
  	i=0
  	rgarr2.each do |haha3|
  		if(haha2.split("\s").last==haha3.split("\s").first)
  			uri = URI.parse("http://172.16.18.230:8080/api/sector/6/company/HM/trajectory")
  			if(i==0)
  				res = Net::HTTP.post_form(uri, 'trajectory' => "#{haha2}")
  			end
  			res = Net::HTTP.post_form(uri, 'trajectory' => "#{haha3}")
  			puts res.body
  		end
  	i+=1
  	end
  end
end
