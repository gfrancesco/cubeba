#!/usr/bin/env ruby

thumbs_d = "thumbs"
display_d = "display"

base_d = "/var/www/cubeba"

d_list = Dir.glob( File.join(base_d,"public","galleria","201*") )

d_list.each do |dir|
  if !File.directory?(File.join(dir,thumbs_d)) && !File.directory?(File.join(dir,display_d))
    Dir.mkdir(File.join(dir,thumbs_d))
    Dir.mkdir(File.join(dir,display_d))
    
    album = File.basename(dir)
    
    files = File.join(dir,"*.{[jJ][pP][gG],[jJ][pP][eE][gG]}")
    f_list = Dir.glob(files).sort_by {|f| File.basename f}
    count = 0
    
    f = File.new(File.join(dir,"_ajax.html"), "w")
    
    f_list.each do |file|
      
      count += 1
      fname = File.basename(file)
      disp_file = File.join(dir,display_d,fname)
      thumb_file = File.join(dir,thumbs_d,fname)
  
      c_disp = "convert #{file} -resize 900\\> #{disp_file}"
      c_thumb = "convert #{file} -resize 90x60! #{thumb_file}"
      system c_disp
      system c_thumb
      
      f.puts "<a href='" + File.join("galleria",album,display_d,fname) + "' rel='thumb'>"
      f.puts "  <img alt='img_" + count.to_s + "' src='" + File.join("galleria",album,thumbs_d,fname) + "' />"
      f.puts "</a>"
      f.puts ""
      
    end
    
    f.close

  end
  
end
